//
//  MarkdownGenerator.swift
//  PlistMapper
//
//  Created by Grzegorz on 22/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

struct Markdown {
    static let fileExtension = "md"
}

protocol MarkdownGenerator: TextContentGenerator {}

extension MarkdownGenerator {

    func rowIndentation(for level:Int) -> String {
        let indent = level > 3 ? String(repeating: "\t", count: level - 4) : ""
        return indent
    }

    func rowPrefix(for level:Int) -> String {
        let prefix = level > 3 ? "-" : String(repeating: "#", count: level)
        return prefix
    }

    func rowBegining(for level:Int) -> String {
        let prefix = self.rowPrefix(for: level)
        let indent = self.rowIndentation(for: level)
        let rowBegining = "\(indent)\(prefix) "
        return rowBegining
    }

    // MARK: - Values

    func rowForKey(_ key:String, indentationLevel level:Int) -> String {
        let rowBegining = self.rowBegining(for: level)
        return "\(rowBegining)\(key)"
    }

    func rowForString(_ value:String, indentationLevel level:Int) -> String {
        let rowIndentation = self.rowIndentation(for: level)
        let rowBegining = self.rowBegining(for: level)
        let hasMultipleLines = value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).contains("\n")
        let isTooLong = value.count > 100
        if hasMultipleLines || isTooLong {
            return "\(rowIndentation)```\n\(rowIndentation)\(value)\n\(rowIndentation)```"
        }
        return "\(rowBegining)`\(value)`"
    }

    func rowForBool(_ value:Bool, indentationLevel level:Int) -> String {
        let rowBegining = self.rowBegining(for: level)
        return "\(rowBegining)\(value ? "YES" : "NO")"
    }

    func rowsForDictionary(_ dict:[String: Any], indentationLevel level:Int) -> [String] {
        let keys = Array(dict.keys).sorted()
        var result:[String] = []
        for key in keys {
            let keyRow = self.rowForKey(key, indentationLevel: level)
            result.append(keyRow)

            if let value = dict[key] {
                let valueRows = self.rows(for: value, indentationLevel: level + 1)
                result.append(contentsOf: valueRows)
            }
        }
        return result
    }

    func rowsForArray(_ array:[Any], indentationLevel level:Int) -> [String] {
        let rows = array.reduce(into: [String]()) { (result, value) in
            let subrows = self.rows(for: value, indentationLevel: level)
            result.append(contentsOf: subrows)
        }
        print("Array: ", rows.joined(separator: "\n"))
        return rows
    }

    func rowForUnknown(_ value:Any, indentationLevel level:Int) -> String {
        let rowBegining = self.rowBegining(for: level)
        return "\(rowBegining)\(String(describing: value))"
    }

    // MARK: - Main
    func rows(for inputValue:Any, indentationLevel level:Int) -> [String] {
        if let string = inputValue as? String {
            return [self.rowForString(string, indentationLevel: level)]
        }else if let bool = inputValue as? Bool {
            return [self.rowForBool(bool, indentationLevel: level)]
        }else if let array = inputValue as? [Any] {
            return self.rowsForArray(array, indentationLevel: level)
        }else if let dict = inputValue as? [String: Any] {
            return self.rowsForDictionary(dict, indentationLevel: level)
        }
        return [self.rowForUnknown(inputValue, indentationLevel: level)]
    }

    func fileContent(for info:PlistDataType) -> String {
        return self.fileContent(for: info, availableAncestorsById: nil)
    }

    private func escaped(path:String) -> String {
        return path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed) ?? path
    }

    func fileContent(for info:PlistDataType, availableAncestorsById:[String: UniquePlistDataType]?) -> String {
        let name = info.title
        let path = info.path
        var dict = info.plist

        let fileName = info.sourceFileName() ?? "Plist Content"
        let fileDir = (path as NSString).deletingLastPathComponent as String
        let escapedFileDir = self.escaped(path: fileDir)
        let excapedPath = self.escaped(path: path)

        let isPathSymbolic = fileDir.starts(with: "~")
        let hasPlistIdentifier = info is UniquePlistDataType

        var content:String
        if isPathSymbolic {
            content = """
            # \(name)\n\n`\(escapedFileDir)`
            > Markdown does not support symbolic links so to open the directory you need to copy its path to finder manualy

            ## \(fileName)\n\n`\(excapedPath)`
            """
        }else{
            content = "# [\(name)](\(escapedFileDir))"
            if !hasPlistIdentifier {
                content += "\n\n## [\(fileName)](\(excapedPath))"
            }else{
                content += "\n\n## \(fileName)"
            }
        }

        if let uniqueInfo = info as? UniquePlistDataType {
            let key = type(of:uniqueInfo).identifierKey
            if let id = dict[key] {
                dict[key] = nil

                // add id first
                content.append("\n\n### \(key)\n\n- \(id)")

                if !isPathSymbolic {
                    content.append(" ( [plist](\(excapedPath)) )")
                }
            }

            // add ancestors
            if let ancestorsKey = type(of:uniqueInfo).ancestorsKey,
                let ancestors = dict[ancestorsKey] as? [String] {
                dict[ancestorsKey] = nil
                
                let keyRow = "\n\n### \(ancestorsKey)"
                content.append(keyRow)

                for identifier in ancestors {
                    var valueRow = "\n\n- \(identifier)"
                    if let ancestorInfo = availableAncestorsById?[identifier],
                        let markdownFileName = ancestorInfo.outputFileName()
                    {
                        let escapedFileDir = self.escaped(path: ancestorInfo.sourceDir())
                        let excapedPath = self.escaped(path: ancestorInfo.path)
                        valueRow += " ( [\(ancestorInfo.title)](\(markdownFileName).\(Markdown.fileExtension)), [directory](\(escapedFileDir)), [plist](\(excapedPath)) )"
                    }
                    content.append(valueRow)
                }
            }
        }

        // add other properties
        let other = self.rows(for: dict, indentationLevel: 3).joined(separator: "\n\n")
        content.append("\n\n---\n\n\(other)")
        return content
    }
}
