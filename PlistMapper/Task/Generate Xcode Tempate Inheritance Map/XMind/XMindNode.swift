//
//  XMindNode.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 06/04/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

extension XMind {
    struct Node: MindMapNodeType {
        static var randomId:String { return UUID().uuidString }
        static let ancestorIdSeparator = "::"

        let id:String
        let text:String
        var plist:[String: Any]?

        /// Contains id of a node duplicated by this node
        var duplicatedId:String? = nil
        var isAncestorsRoot:Bool = false
        var structureClass:StructureClass? // = .logicRight

        var timeStamp:Date = Date()
        var children:[Node] = []

        var depthLevel:Int {
            let level = self.children.count > 0 ? 1 : 0
            return level + children.reduce(0, { (prev, child) -> Int in
                return max(prev, child.depthLevel)
            })
        }

        /**
         Init with plist root node.

         - Parameter info: Root node of the (sub)branch
         - Parameter fullMap: If `true` node will have loaded also its children from `plist` for every key.
         */
        init<T>(with info:T, fullMap:Bool = false) where T:UniquePlistDataProtocol {
            self.id = "\(info.identifier)\(Node.ancestorIdSeparator)\(Node.randomId)"
            self.text = info.title
            self.plist = info.plist
            if fullMap {
                self.loadChildrenFormPlist()
            }
        }

        /**
         Init with plist root node.

         - Parameter info: Root node of the (sub)branch
         - Parameter ancestorsById: Known ancestrs plists data, if provided
         allows to load whole inheritance hierarchy, not only the ancestors
         ids like in case of `init(with:,fullMap:)`
         - Parameter fullMap: If `true` node will have also its children loaded
         from `plist` for every key, and for available ancestors data
         (`ancestorsById`) ancestors will be resolved to full branch for every known ancestor
         */
        init<T>(with info: T, ancestorsById: [String : T]?, fullMap:Bool = false) where T:UniquePlistDataProtocol {
            self.init(with: info, fullMap: fullMap)

            if ancestorsById != nil {
                let ancestors = self.ancestorNodes(with: info, availableAncestorsById: ancestorsById!, fullMap: fullMap)

                // list ancestors in separate child node
                if fullMap, let ancestorsKey = type(of: info).ancestorsKey {
                    if ancestors.count > 0 {
                        var ancestorsNode = Node(value: ancestorsKey)
                        ancestorsNode.isAncestorsRoot = true
                        ancestorsNode.children = ancestors
                        let children = self.children.filter({ $0.text != ancestorsKey })
                        self.children = children + [ancestorsNode]
                    }
                }else{
                    self.children = self.children + ancestors
                }
            }
        }

        /// Template ancestors nodes
        /// Ancestors are children nodes with complex id composed with template id and random UUID
        func ancestorsFlatMap() -> [Node] {
            let ancestors = self.children.reduce(into: [Node]()) { (result, child) in
                let isAcestor = child.id.contains(Node.ancestorIdSeparator)
                if isAcestor {
                    result.append(child)
                }

                /// is node which has ancestors as its children
                let isAncestorsRoot = child.isAncestorsRoot
                if isAcestor || isAncestorsRoot {
                    result.append(contentsOf: child.ancestorsFlatMap())
                }
            }
            return ancestors
        }

        /**
         Marks duplicated descendants by setting its `duplicatedId` value

         - Parameter removeChildren: force removing children of duplicated node to obtimize size of mind map
         */
        mutating func markDuplicatedAncestors(removeChildren:Bool = false) {
            /// contains id of node to reference to in case of duplication by its prefix as key
            /// prefix is an orginal template id
            var knownNodesByIdPrefixes:[String:String] = [:]
            self._markDuplicatedAncestors(knownNodesByIdPrefixes: &knownNodesByIdPrefixes, removeChildren:removeChildren)
        }

        fileprivate mutating func _markDuplicatedAncestors(knownNodesByIdPrefixes:inout [String:String], removeChildren:Bool) {
            for index in (0..<self.children.count) {
                var child = self.children[index]
                child._markDuplicatedAncestors(knownNodesByIdPrefixes: &knownNodesByIdPrefixes, removeChildren:removeChildren)
                self.children[index] = child

                let components = child.id.components(separatedBy: Node.ancestorIdSeparator)

                /// Is it node containing Template Name (ancesstor node)
                let isTemplateRootNode = components.count == 2
                if isTemplateRootNode, let prefix = components.first {
                    if let duplicatedNodeId = knownNodesByIdPrefixes[prefix] {
                        child.duplicatedId = duplicatedNodeId
                        if removeChildren {
                            child.children = []
                        }
                        self.children[index] = child
                    }else{
                        knownNodesByIdPrefixes[prefix] = child.id
                    }
                }
            }
        }

        // MARK: - Full Map Support
        // Full Maps are broken because xml as node text is not supported

        init(value:Any) {
            self.id = Node.randomId
            self.text = "\(value)"
        }

        init(key:String, value:Any) {
            self.id = Node.randomId
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

    
}
