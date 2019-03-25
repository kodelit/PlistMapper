//
//  FreeMindGenerator.swift
//  PlistMapper
//
//  Created by Grzegorz on 24/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

struct FreeMind {
    static let fileExtension = "mm"

    enum Position: String {
        case left, right
    }

    struct Node: MindMapNodeType {
        let id:String
        let text:String
        let created:Date
        var modified:Date = Date()

        var link:String? = nil
        var position:Position? = nil
        var children:[Node] = []

        var escapedLink:String? {
            return link?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed) ?? link
        }

        init(id: String, created: Date = Date(), modified: Date = Date(), text: String, link:String? = nil, position: Position = .right, children:[Node] = []) {
            self.id = id
            self.created = created
            self.modified = modified
            self.link = link
            self.text = text
            self.position = position
            self.children = children
        }

        init(with info:UniquePlistDataType) {
            self.id = info.identifier
            self.text = info.title
            self.created = Date()
        }

        init(with info: UniquePlistDataType, ancestorsById: [String : UniquePlistDataType]?) {
            self.init(with: info)

            if ancestorsById != nil {
                let ancestors = self.ancestorNodes(with: info, availableAncestorsById: ancestorsById!)
                let children = self.children + ancestors
                self.children = children
            }
        }
    }

    struct Template {

        struct Token {
            static let content = "##content##"
            static let created = "##created##"
            static let id = "##id##"
            static let linkAttribute = "##linkAttribute##"
            static let link = "##link##"
            static let modified = "##modified##"
            static let positionAttribute = "##positionAttribute##"
            static let position = "##position##"
            static let text = "##text##"
        }

        static let container = """
        <?xml version="1.0" encoding="UTF-8" standalone="no"?>
        <map version="0.8.1">
        \(Token.content)
        </map>
        """

        static let leaf = """
        <node CREATED="\(Token.created)" ID="\(Token.id)"\(Token.linkAttribute) MODIFIED="\(Token.modified)"\(Token.positionAttribute) TEXT="\(Token.text)"/>
        """

        static let branchBegin = """
        <node CREATED="\(Token.created)" ID="\(Token.id)"\(Token.linkAttribute) MODIFIED="\(Token.modified)"\(Token.positionAttribute) TEXT="\(Token.text)">
        """

        static let branchEnd = "</node>"

        static let positionAttribute = " POSITION=\"\(Token.position)\""
        static let linkAttribute = " LINK=\"\(Token.link)\""

        static let topicTokens = [Token.id, Token.created, Token.linkAttribute, Token.modified, Token.text, Token.positionAttribute]
    }
}

struct FreeMindGenerator: TextContentGenerator {
    typealias Token = FreeMind.Template.Token
    typealias Template = FreeMind.Template
    typealias Node = FreeMind.Node

    func fileContent(for info:PlistDataType, availableAncestorsById:[String: UniquePlistDataType]?) -> String {
        var content:String = ""

        if let uniqueInfo = info as? UniquePlistDataType {
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
