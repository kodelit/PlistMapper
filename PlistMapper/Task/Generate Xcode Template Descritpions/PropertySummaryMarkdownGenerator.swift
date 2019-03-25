//
//  PropertySummaryMarkdownGenerator.swift
//  PlistMapper
//
//  Created by Grzegorz on 25/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

/**
 Collects all values for property of plist and its ancestors.
 */
protocol PropertySummaryMarkdownGenerator: MarkdownGenerator {
    var propertyName:String { get }
}

extension PropertySummaryMarkdownGenerator {
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
