//
//  FreeMindGenerator.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 24/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

/// FreeMindGenerator only supports inhertitance maps and is not developed for now
struct FreeMindGenerator: TextContentGeneratorProtocol {
    typealias Token = FreeMind.Template.Token
    typealias Template = FreeMind.Template
    typealias Node = FreeMind.Node

    func fileContent<T>(for info:PlistDataProtocol, availableAncestorsById:[String: T]?) -> String where T:UniquePlistDataProtocol {
        var content:String = ""

        if let uniqueInfo = info as? T {
            let rootNode = Node(with: uniqueInfo, ancestorsById: availableAncestorsById)
            let rows = self.branch(for: rootNode)
            content = rows.joined(separator: "\n")
        }

        return Template.container.replacingOccurrences(of: Token.content, with: content)
    }

    func branch(for node:Node, level:Int = 1) -> [String] {
        let hasChildren = node.children.count > 0
        let branchTemplate = hasChildren ? Template.branchBegin : Template.leaf
        let row = Template.topicTokens.reduce(branchTemplate) { (result, token) -> String in
            var value:String = ""
            switch token {
            case Token.id:
                value = node.id
            case Token.created:
                value = node.created.timestampString()
            case Token.modified:
                value = node.modified.timestampString()
            case Token.text:
                value = node.text
            case Token.positionAttribute:
                if node.position != nil {
                    value = Template.positionAttribute.replacingOccurrences(of: Token.position, with: node.position!.rawValue)
                }
            case Token.linkAttribute:
                if node.link != nil {
                    value = Template.linkAttribute.replacingOccurrences(of: Token.link, with: node.link!)
                }
            default: break
            }
            return result.replacingOccurrences(of: token, with: value)
        }

        let indentation = self.rowIndentation(for: level)

        // first row
        let firstRow = indentation + row
        var rows:[String] = [firstRow]

        guard hasChildren else {
            return rows
        }

        // children
        rows = node.children
            .reduce(into: rows, { (result, child) in
                let childRows = self.branch(for: child, level: level + 1)
                result.append(contentsOf: childRows)
            })

        // last row
        let lastRow = indentation + Template.branchEnd
        rows.append(lastRow)

        return rows
    }
}
