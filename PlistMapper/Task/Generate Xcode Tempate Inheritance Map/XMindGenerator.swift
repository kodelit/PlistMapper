//
//  XMindGenerator.swift
//  PlistMapper
//
//  Created by Grzegorz on 24/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

struct XMind {
    static let fileExtension = "xmind"

    struct Node: MindMapNodeType {
        let id:String
        let text:String

        var timeStamp:Date = Date()
        var children:[Node] = []

        init(id: String, text: String, timeStamp: Date = Date(), children:[Node] = []) {
            self.id = id
            self.timeStamp = timeStamp
            self.text = text
            self.children = children
        }

        init(with info:UniquePlistDataType) {
            self.id = info.identifier
            self.text = info.title
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
            static let timeStamp = "##timestamp##"
            static let id = "##id##"
            static let structureClassAttribute = "##structureClassAttribute##"
            static let linkAttribute = "##linkAttribute##"
            static let link = "##link##"
            static let modifiedBy = "##modifiedby##"

            static let sheetName = "##sheetName##"
            static let relationships = "##relationships##"
        }

        static let modifiedBy = "PlistMapper"
        static let style = "43immodm6i9ppor1t7uf68ui7o"
        static let structureClass = "org.xmind.ui.logic.right"

        static let container = """
        <?xml version="1.0" encoding="UTF-8" standalone="no"?>
        <xmap-content modified-by="g.maciak" timestamp="1553454457298" version="2.0" xmlns="urn:xmind:xmap:xmlns:content:2.0" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:xlink="http://www.w3.org/1999/xlink">
            <sheet id="\(Token.id)" modified-by="\(modifiedBy)" theme="\(style)" timestamp="\(Token.timeStamp)">
                \(Token.content)
                <title>\(Token.sheetName)</title>
                <relationships>\(Token.relationships)</relationships>
            </sheet>
        </xmap-content>
        """

        static let topic = """
        <topic id="\(Token.id)"\(Token.linkAttribute) modified-by="\(modifiedBy)"\(structureClassAttribute) timestamp="\(Token.timeStamp)">\(Token.content)</topic>
        """
        static let title = "<title>\(Token.content)</title>"
        static let children = "<children>\(Token.content)</children>"
        static let topics = "<topics type=\"attached\">\(Token.content)</topics>"

        static let relationships = "<relationships>\(Token.content)</relationships>"
        static let relationship = """
        <relationship end1="762ha5oil0nq4ftm0hvfq3607p" end2="7vtkm8acfs8ef91m5mp0bjjtd0" id="6295fbues7jbe8r2k31cdep0rb" modified-by="g.maciak" timestamp="1553519493701" />
        """

        static let linkAttribute = " xlink:href=\"\(Token.link)\""
        static let structureClassAttribute = " structure-class=\"\(structureClass)\""
    }
}

struct XMindGenerator: TextContentGenerator {
    typealias Token = XMind.Template.Token
    typealias Template = XMind.Template
    typealias Node = XMind.Node

    func fileContent(for info:PlistDataType, availableAncestorsById:[String: UniquePlistDataType]?) -> String {
        var content:String = ""

        guard let uniqueInfo = info as? UniquePlistDataType else {
            return content
        }

        let rootNode = Node(with: uniqueInfo, ancestorsById: availableAncestorsById)
        content = self.topic(for: rootNode)

        let containerTokens = [Token.id, Token.timeStamp, Token.content, Token.sheetName, Token.relationships]
        let container = containerTokens.reduce(Template.container) { (result, token) -> String in
            var value:String = ""
            switch token {
            case Token.id:
                value = "sheet:\(rootNode.id)"
            case Token.timeStamp:
                value = rootNode.timeStamp.timestampString()
            case Token.content:
                value = content
            case Token.sheetName:
                value = rootNode.text
            default: break
            }
            return result.replacingOccurrences(of: token, with: value)
        }

        return container
    }

    /// !!!: CODE DEPENDS ON `MarkdownOutput`
    func topic(for node:Node, level:Int = 1) -> String {
        let structureClassAttribute = level == 1 ? Template.structureClassAttribute : ""
        let topicTokens = [Token.id, Token.timeStamp, Template.structureClassAttribute, Token.linkAttribute, Token.content]

        let topic = topicTokens.reduce(Template.topic) { (result, token) -> String in
            var value:String = ""
            switch token {
            case Token.id:
                value = node.id
            case Token.linkAttribute:
                if let link = node.link {
                    value = Template.linkAttribute.replacingOccurrences(of: Token.link, with: link)
                }
            case Token.structureClassAttribute:
                value = structureClassAttribute
            case Token.timeStamp:
                value = node.timeStamp.timestampString()
            case Token.content:
                let title = Template.title.replacingOccurrences(of: Token.content, with: node.text)

                // children
                let childTopics = node.children
                    .reduce(into: [String](), { (result, child) in
                        let childTopic = self.topic(for: child, level: level + 1)
                        result.append(childTopic)
                    })
                    .joined(separator: "")

                let topics = Template.topics.replacingOccurrences(of: Token.content, with: childTopics)
                let children = Template.children.replacingOccurrences(of: Token.content, with: topics)
                value = title + children
            default: break
            }
            return result.replacingOccurrences(of: token, with: value)
        }
        return topic
    }
}
