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

    static var noIndentationLevel:Int { return 3 }

    func rowIndentation(for level:Int) -> String {
        let indent = level > Self.noIndentationLevel ? String(repeating: "\t", count: level - 4) : ""
        return indent
    }

    func rowPrefix(for level:Int) -> String {
        let prefix = level > Self.noIndentationLevel ? "-" : String(repeating: "#", count: level)
        return prefix
    }

    func rowBegining(for level:Int = noIndentationLevel) -> String {
        let prefix = self.rowPrefix(for: level)
        let indent = self.rowIndentation(for: level)
        let rowBegining = "\(indent)\(prefix) "
        return rowBegining
    }

    func valueSufixWith(key:String?, level:Int) -> String {
        guard key != nil else {
            return self.rowBegining(for: level)
        }
        let characterSet = CharacterSet.punctuationCharacters
        let shouldDisplayAsCode = key!.rangeOfCharacter(from: characterSet) != nil
        let displayedKey = shouldDisplayAsCode ? "`\(key!)`" : key!
        let sufix = self.rowBegining(for: level) + "\(displayedKey) : "
        return sufix
    }

    // MARK: - Values

    func rowForKey(_ key:String, indentationLevel level:Int) -> String {
        return self.valueSufixWith(key: key, level: level)
    }

    func rowForString(_ value:String, key:String? = nil, indentationLevel level:Int = noIndentationLevel) -> String {
        let rowIndentation = self.rowIndentation(for: level)
        let valueSufix = self.valueSufixWith(key: key, level: level)
        let hasMultipleLines = value.contains("\n")
        let isTooLong = value.count > 100
        let multilineSufix = key != nil ? valueSufix : rowIndentation
        if hasMultipleLines || isTooLong {
            let multilineSufix = key != nil ? valueSufix : rowIndentation
            let adjustedValue = value.components(separatedBy: "\n").joined(separator: "\n\(rowIndentation)")
            return "\(multilineSufix)" + "\n\n\(rowIndentation)```\n\(rowIndentation)\(adjustedValue)\n\(rowIndentation)```"
        }
        return "\(multilineSufix)" + "`\(value)`"
    }

    func rowForBool(_ value:Bool, key:String? = nil, indentationLevel level:Int) -> String {
        return "\(self.valueSufixWith(key: key, level: level))" + "`\(value ? "YES" : "NO")`"
    }

    func rowForNumber(_ value:NSNumber, key:String? = nil, indentationLevel level:Int) -> String {
        return "\(self.valueSufixWith(key: key, level: level))" + "`\(String(describing: value))`"
    }

    func rowsForDictionary(_ dict:[String: Any], indentationLevel level:Int) -> [String] {
        let keys = Array(dict.keys).sorted()
        var result:[String] = []
        for key in keys {
            if let value = dict[key] {
                let valueRows:[String]
                if let string = value as? String {
                    valueRows = [self.rowForString(string, key:key, indentationLevel: level)]
                }else if let bool = value as? Bool {
                    valueRows = [self.rowForBool(bool, key:key, indentationLevel: level)]
                }else if let number = value as? NSNumber {
                    valueRows = [self.rowForNumber(number, key:key, indentationLevel: level)]
                }else{
                    let keyRow = self.rowForKey(key, indentationLevel: level)
                    result.append(keyRow)

                    valueRows = self.rows(for: value, indentationLevel: level + 1)
                }
                result.append(contentsOf: valueRows)
            }

        }
        return result
    }

    func rowsForArray(_ array:[Any], indentationLevel level:Int) -> [String] {
        var rows:[String] = []
        if let list = array as? [String] {
            for (index, value) in list.enumerated() {
                let text = self.rowForString(value, key: "\(index)", indentationLevel: level)
                rows.append(text)
            }
        }else{
            for (index, value) in array.enumerated() {
                let keyRow = self.rowForKey("\(index)", indentationLevel: level)
                rows.append(keyRow)

                let subrows = self.rows(for: value, indentationLevel: level + 1)
                rows.append(contentsOf: subrows)
            }
//            rows = array.reduce(into: [String]()) { (result, value) in
//                let subrows = self.rows(for: value, indentationLevel: level)
//                result.append(contentsOf: subrows)
//            }
        }
        return rows
    }

    func rowForUnknown(_ value:Any, key:String? = nil, indentationLevel level:Int) -> String {
        return "\(self.valueSufixWith(key: key, level: level))`\(String(describing: value))`"
    }

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

    // MARK: - Main

    func fileContent(for info:PlistDataType, availableAncestorsById:[String: UniquePlistDataType]?) -> String {
        let name = info.title
        let path = info.path
        var dict = info.plist

        let fileName = info.sourceFileName() ?? "Plist Content"
        let fileDir = (path as NSString).deletingLastPathComponent as String
        let escapedFileDir = fileDir.escapedPath()
        let excapedPath = path.escapedPath()

        let isPathSymbolic = fileDir.starts(with: "~")
        let hasPlistIdentifier = info is UniquePlistDataType

        var content:String
        if isPathSymbolic {
            content = """
            # \(name)\n\n`\(escapedFileDir)`
            > Markdown does not support symbolic links so to open the directory you need to copy its path to finder manualy

            ## \(fileName)\n\n`\(excapedPath)`
            """
        }else if !hasPlistIdentifier {
            content = """
            # [\(name)](\(escapedFileDir))

            ## [\(fileName)](\(excapedPath))
            """
        }else{
            content = """
            # \(name)

            ## \(fileName)
            """
        }

        if let uniqueInfo = info as? UniquePlistDataType {
            let key = type(of:uniqueInfo).identifierKey
            if let id = dict[key] {
                dict[key] = nil

                // add id first
                content.append("\n\n### \(key)\n\n- \(id)")

                if !isPathSymbolic {
                    content.append(" ( [directory](\(escapedFileDir)), [plist](\(excapedPath)) )")
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
                        let escapedDescriptionFileName = "\(markdownFileName).\(Markdown.fileExtension)".escapedPath()
                        let escapedFileDir = ancestorInfo.sourceDir().escapedPath()
                        let excapedPath = ancestorInfo.path.escapedPath()
                        valueRow += " ( [**\(ancestorInfo.title)**](\(escapedDescriptionFileName)), [directory](\(escapedFileDir)), [plist](\(excapedPath)) )"
                    }
                    content.append(valueRow)
                }
            }
        }

        // add other properties
        let other = self.rows(for: dict, indentationLevel: Self.noIndentationLevel).joined(separator: "\n\n")
        content.append("\n\n---\n\n\(other)")
        return content
    }
}
