//
//  XMindGeneratorProtocol.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 07/04/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

protocol XMindGeneratorProtocol: TextContentGeneratorProtocol {
    typealias Token = XMind.Template.Token
    typealias Template = XMind.Template
    typealias Node = XMind.Node

    var fullMap:Bool { get set }
    var ancestorsFolded:Bool { get set }
    var foldDeepNodes:Bool { get set }

    func fileContent(for rootNode:Node) -> String
    func topic(for node:Node, level:Int) -> String
}

extension XMindGeneratorProtocol {

    func fileContent<T>(for info:PlistDataProtocol, availableAncestorsById:[String: T]?) -> String where T:UniquePlistDataProtocol {
        guard let uniqueInfo = info as? T else {
            return ""
        }

        var rootNode = Node(with: uniqueInfo, ancestorsById: availableAncestorsById, fullMap: self.fullMap)
        rootNode.markDuplicatedAncestors(removeChildren: self.fullMap)
        return fileContent(for: rootNode)
    }

    func fileContent(for rootNode:Node) -> String {
        let timeStamp = rootNode.timeStamp.timestampString()
        let duplicates = rootNode.ancestorsFlatMap().filter({ $0.duplicatedId != nil })
        let content = self.topic(for: rootNode)

        /*
         Timestamp token is omited for purpose, it will cause that
         timestamp will be set at the higher level of content tokens replacement
         */
        let relationsipTokens = [Token.relationshipSourceNodeId, Token.relationshipTargetNodeId, Token.id, Token.content]
        let relationsipTitle = Template.title.replacingOccurrences(of: Token.content, with: "<< duplicate of >>")
        let relationsipRows:[String] = duplicates.reduce(into: [String](), { (result, duplicate) in
            if let targetId = duplicate.duplicatedId {
                let params = [
                    Token.relationshipSourceNodeId: duplicate.id,
                    Token.relationshipTargetNodeId: targetId,
                    Token.id: Node.randomId,
                    Token.content: relationsipTitle]

                let content = self.content(with: Template.relationship, tokensInOrder: relationsipTokens, valuesByToken: params)
                result.append(content)
            }
        })
        let relationshipsContent = relationsipRows.joined(separator: "")
        let relationships = Template.relationships.replacingOccurrences(of: Token.content, with: relationshipsContent)

        /* !!!:
         Token.timeStamp at the end of the list will guarantee to set the
         value for every mistakenly skipped timestamps
         */
        let containerTokens = [Token.id, Token.content, Token.sheetName, Token.relationships, Token.timeStamp]
        let params = [
            Token.id: "sheet:\(rootNode.id)",
            Token.content: content,
            Token.sheetName: rootNode.text,
            Token.relationships: relationships,
            Token.timeStamp: timeStamp]

        let container = self.content(with: Template.container, tokensInOrder: containerTokens, valuesByToken: params)
        return container
    }

    func content(with template:String, tokensInOrder tokens:[String], valuesByToken:[String: String]) -> String {
        let content = tokens.reduce(template) { (result, token) -> String in
            let value = valuesByToken[token] ?? ""
            return result.replacingOccurrences(of: token, with: value)
        }
        return content
    }

    func topic(for node:Node, level:Int = 1) -> String {
        let isRootTopic = level == 1
        /// Default root node structure class
        let structureClass = isRootTopic ? XMind.StructureClass.logicRight : nil
        let topicTokens = [Token.id, Token.timeStamp, Token.branchAttribute, Token.structureClassAttribute, Token.linkAttribute, Token.content]

        let topic = topicTokens.reduce(Template.topic) { (result, token) -> String in
            var value:String = ""
            switch token {
            case Token.id:
                value = node.id
            case Token.branchAttribute:
                let isDuplicate = node.duplicatedId != nil
                let shouldFold = isDuplicate
                    // fold ancestor if needed
                    || (self.ancestorsFolded && node.link != nil)
                    // fold deep nodes
                    || (!isRootTopic && self.foldDeepNodes && node.depthLevel > 1)

                if shouldFold {
                    value = Template.branchAttribute
                }
            case Token.linkAttribute:
                if let link = node.link {
                    value = Template.linkAttribute.replacingOccurrences(of: Token.link, with: link)
                }
            case Token.structureClassAttribute:
                if let structureClass = node.structureClass ?? structureClass {
                    value = Template.structureClassAttribute.replacingOccurrences(of: Token.content, with: structureClass.rawValue)
                }
            case Token.timeStamp:
                value = node.timeStamp.timestampString()
            case Token.content:
                let text = node.text + (node.duplicatedId != nil ? " ( IGNORED )" : "")
                let title = Template.title.replacingOccurrences(of: Token.content, with: text)

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
