//
//  XcodeTemplateInfoMarkdownGenerator.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 26/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

struct XcodeTemplateInfoMarkdownGenerator: MarkdownGenerator {}

struct XcodeTemplateCombinedInfoMarkdownGenerator: MarkdownGenerator {
//    var outputFileName:String? = nil
//
//    func fileName(for key:String) -> String {
//        guard let outputFileName = self.outputFileName else {
//            fatalError("Unknown output file name!")
//        }
//        return "\(outputFileName).\(Markdown.fileExtension)".escapedPath()
//    }

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
                        keyRow = "\(keyRow) <span id=\"f_\(key)\"/>[↩](#a_\(key))"
                    }
                    result.append(keyRow)

                    valueRows = self.rows(for: value, indentationLevel: level + 1)
                }
                result.append(contentsOf: valueRows)
            }
        }
        return result
    }

    func fileContent<T>(for info:PlistDataProtocol, availableAncestorsById:[String: T]?) -> String where T:UniquePlistDataProtocol {
        var templateInfo = info
        var content = self.fileHead(for: &templateInfo, availableAncestorsById: availableAncestorsById)

        let dict = templateInfo.plist
        let keys = Array(dict.keys).sorted()
        let menuLinks = keys.compactMap { (key) -> String? in
            if let value = dict[key], value is [String: Any] || value is [Any] {
                return "<span id=\"a_\(key)\">[\(key)](#f_\(key))</span>"
            }
            return nil
        }
        let menuLine = menuLinks.joined(separator: " | ")

        // add other properties
        let other = self.fileBody(with: dict)
        content.append("\n\n---\n\(menuLine)\n\n\(other)")
        return content
    }
}
