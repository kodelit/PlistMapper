//
//  MarkdownGenerator.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 22/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

struct Markdown {
    static let fileExtension = "md"
}

protocol MarkdownGenerator: TextContentGeneratorProtocol {

    // MARK: With default implementations
    func rowForKey(_ key:String, indentationLevel level:Int) -> String
    func rowForString(_ value:String, key:String?, indentationLevel level:Int) -> String
    func rowForBool(_ value:Bool, key:String?, indentationLevel level:Int) -> String
    func rowForNumber(_ value:NSNumber, key:String?, indentationLevel level:Int) -> String
    func rowsForArray(_ array:[Any], indentationLevel level:Int) -> [String]
    func rowsForDictionary(_ dict:[String: Any], indentationLevel level:Int) -> [String]
    func rowForUnknown(_ value:Any, key:String?, indentationLevel level:Int) -> String

    func rows(for inputValue:Any, indentationLevel level:Int) -> [String]

    func fileHead<T>(for info:inout PlistDataProtocol, availableAncestorsById:[String: T]?) -> String where T:UniquePlistDataProtocol
    func fileBody(with dict:[String: Any]) -> String
}


// MARK: - Default Implementations

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
                    var keyRow = self.rowForKey(key, indentationLevel: level)
                    if level == XcodeTemplateCombinedInfoMarkdownGenerator.noIndentationLevel {
                        keyRow = "\(keyRow) <span id=\"a_\(key)\"/>[↩](#m_\(key))"
                    }
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

    func fileContent<T>(for info:PlistDataProtocol, availableAncestorsById:[String: T]?) -> String where T:UniquePlistDataProtocol {
        var templateInfo = info
        var content = self.fileHead(for: &templateInfo, availableAncestorsById: availableAncestorsById)
        /// Plist potentialy updated by the header generator
        let dict = templateInfo.plist

        let keys = Array(dict.keys).sorted().compactMap { (key) -> String? in
            if let value = dict[key], value is [String: Any] || value is [Any] {
                return key
            }
            return nil
        }
        let links = self.fileMenu(with: keys)
        content.append("\n\n---\n\(links)")

        // add other properties
        let other = self.fileBody(with: dict)
        content.append("\n\n\(other)")
        return content
    }

    func fileHead<T>(for info:inout PlistDataProtocol, availableAncestorsById:[String: T]?) -> String where T:UniquePlistDataProtocol {
        let name = info.title
        let path = info.path
        var dict = info.plist

        let fileName = info.sourceFileName() ?? "Plist Content"
        let fileDir = (path as NSString).deletingLastPathComponent as String
        let escapedFileDir = fileDir.escapedPath()
        let excapedPath = path.escapedPath()

        let isPathSymbolic = fileDir.starts(with: "~")
        let hasPlistIdentifier = info is T

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

        if let uniqueInfo = info as? T {
            let key = type(of:uniqueInfo).identifierKey
            // remove id to avoid repetition
            dict[key] = nil

            // add id first
            let id = uniqueInfo.identifier
            content.append("\n\n### \(key)\n\n- \(id)")

            if !isPathSymbolic {
                content.append(" ( [directory](\(escapedFileDir)), [plist](\(excapedPath)) )")
            }

            // add ancestors
            if let ancestorsKey = type(of:uniqueInfo).ancestorsKey,
                let ancestors = uniqueInfo.ancestorsIds() {
                // remove ancestors to avoid repetition
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

                        let isPathSymbolic = escapedFileDir.starts(with: "~")
                        if isPathSymbolic {
                            valueRow += " ( [**\(ancestorInfo.title)**](\(escapedDescriptionFileName)) )"
                        }else{
                            let excapedPath = ancestorInfo.path.escapedPath()
                            valueRow += " ( [**\(ancestorInfo.title)**](\(escapedDescriptionFileName)), [directory](\(escapedFileDir)), [plist](\(excapedPath)) )"
                        }

                    }
                    content.append(valueRow)
                }
            }
        }

        info.plist = dict
        return content
    }

    func fileMenu(with keys:[String]) -> String {
        let links = keys.map { (key) -> String in
            return "<span id=\"m_\(key)\">[\(key)](#a_\(key.escapedPath()))</span>"
        }
        let linksRow = links.joined(separator: " | ")
        return linksRow
    }

    func fileBody(with dict:[String: Any]) -> String {
        let other = self.rows(for: dict, indentationLevel: Self.noIndentationLevel).joined(separator: "\n\n")
        return other
    }
}
