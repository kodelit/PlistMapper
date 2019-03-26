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
        var plist:[String: Any]?
        var duplicate:Bool = false

        var timeStamp:Date = Date()
        var children:[Node] = []

        init(with info:UniquePlistDataType, fullMap:Bool = false) {
            self.id = "\(info.identifier)::\(UUID().uuidString)"
            self.text = info.title
            self.plist = info.plist
            if fullMap {
                self.loadChildrenFormPlist()
            }
        }

        init(with info: UniquePlistDataType, ancestorsById: [String : UniquePlistDataType]?, fullMap:Bool = false) {
            self.init(with: info, fullMap: fullMap)

            if ancestorsById != nil {
                let ancestors = self.ancestorNodes(with: info, availableAncestorsById: ancestorsById!, fullMap: fullMap)
                
                if fullMap, let ancestorsKey = type(of: info).ancestorsKey {
                    var ancestorsNode = Node(value: ancestorsKey)
                    ancestorsNode.children = ancestors
                    let children = self.children.filter({ $0.text != ancestorsKey })
                    self.children = children + [ancestorsNode]
                }else{
                    self.children = self.children + ancestors
                }
            }
        }

        mutating func markDuplicatedChildren() {
            var prefixes:[String] = []
            self._markDuplicatedChildren(knownPrefixes: &prefixes)
        }

        fileprivate mutating func _markDuplicatedChildren(knownPrefixes:inout [String]) {
            for index in 0..<self.children.count {
                var child = self.children[index]
                let components = child.id.components(separatedBy: "::")
                if components.count == 2, let prefix = components.first {
                    if knownPrefixes.contains(prefix) {
                        child.duplicate = true
                        self.children[index] = child
                    }else{
                        knownPrefixes.append(prefix)
                    }
                }
            }

            for index in 0..<self.children.count {
                var child = self.children[index]
                child._markDuplicatedChildren(knownPrefixes: &knownPrefixes)
                self.children[index] = child
            }
        }

        // MARK: - Full Map Support
        // Full Maps are broken because xml as node text is not supported
        
        init(value:Any) {
            self.id = UUID().uuidString
            self.text = "\(value)"//.escapedXML()
        }

        init(key:String, value:Any) {
            self.id = UUID().uuidString
            self.text = key
            if let dict = value as? [String: Any] {
                self.plist = dict
                self.loadChildrenFormPlist()
            }
            else if let array = value as? [Any] {
                var children:[Node] = []
                for (index, element) in array.enumerated() {
                    children.append(Node(key: "\(index)", value: element))
                }
                self.children = self.children + children
            }
            else{
                self.children = self.children + [Node(value: value)]
            }
        }

        mutating func loadChildrenFormPlist() {
            guard let plist = self.plist else {
                return
            }
            var children:[Node] = []
            for (key, element) in plist {
                children.append(Node(key: "\(key)", value: element))
            }
            self.children = self.children + children
        }
    }

    struct Template {
        struct Token {
            static let content = "##content##"
            static let timeStamp = "##timestamp##"
            static let id = "##id##"
            static let link = "##link##"
            static let modifiedBy = "##modifiedby##"

            static let branchAttribute = "#branchAttribute##"
            static let structureClassAttribute = "##structureClassAttribute##"
            static let linkAttribute = "##linkAttribute##"

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
        <topic \(Token.branchAttribute) id="\(Token.id)"\(Token.linkAttribute) modified-by="\(modifiedBy)"\(structureClassAttribute) timestamp="\(Token.timeStamp)">\(Token.content)</topic>
        """
        static let title = "<title><![CDATA[\(Token.content)]]></title>"
        static let children = "<children>\(Token.content)</children>"
        static let topics = "<topics type=\"attached\">\(Token.content)</topics>"

        static let relationships = "<relationships>\(Token.content)</relationships>"
        static let relationship = """
        <relationship end1="762ha5oil0nq4ftm0hvfq3607p" end2="7vtkm8acfs8ef91m5mp0bjjtd0" id="6295fbues7jbe8r2k31cdep0rb" modified-by="g.maciak" timestamp="1553519493701" />
        """

        static let branchAttribute = " branch=\"folded\""
        static let linkAttribute = " xlink:href=\"\(Token.link)\""
        static let structureClassAttribute = " structure-class=\"\(structureClass)\""
    }
}

struct XMindGenerator: TextContentGenerator {
    typealias Token = XMind.Template.Token
    typealias Template = XMind.Template
    typealias Node = XMind.Node

    var fullMap:Bool = false
    var ancestorsFolded:Bool = false

    func fileContent(for info:PlistDataType, availableAncestorsById:[String: UniquePlistDataType]?) -> String {
        var content:String = ""

        guard let uniqueInfo = info as? UniquePlistDataType else {
            return content
        }

        var rootNode = Node(with: uniqueInfo, ancestorsById: availableAncestorsById, fullMap: self.fullMap)
        rootNode.markDuplicatedChildren()
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
        let isRootTopic = level == 1
        let structureClassAttribute = isRootTopic ? Template.structureClassAttribute : ""
        let topicTokens = [Token.id, Token.timeStamp, Token.branchAttribute, Token.structureClassAttribute, Token.linkAttribute, Token.content]

        let topic = topicTokens.reduce(Template.topic) { (result, token) -> String in
            var value:String = ""
            switch token {
            case Token.id:
                value = node.id
            case Token.branchAttribute:
                if node.duplicate || (self.ancestorsFolded && !isRootTopic && node.link != nil) {
                    value = Template.branchAttribute
                }
            case Token.linkAttribute:
                if let link = node.link {
                    value = Template.linkAttribute.replacingOccurrences(of: Token.link, with: link)
                }
            case Token.structureClassAttribute:
                value = structureClassAttribute
            case Token.timeStamp:
                value = node.timeStamp.timestampString()
            case Token.content:
                let text = node.text + (node.duplicate ? " (DUPLICATED)" : "")
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
