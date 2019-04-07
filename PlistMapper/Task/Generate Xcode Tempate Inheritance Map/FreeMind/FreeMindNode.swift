//
//  FreeMindNode.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 06/04/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

extension FreeMind {
    struct Node: MindMapNodeType {
        let id:String = UUID().uuidString
        let text:String
        let created:Date
        var modified:Date = Date()

        var link:String? = nil
        var position:Position? = nil
        var children:[Node] = []

        var escapedLink:String? {
            return link?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed) ?? link
        }

        init(text: String, created: Date = Date(), modified: Date = Date(), link:String? = nil, position: Position = .right, children:[Node] = []) {
            self.created = created
            self.modified = modified
            self.link = link
            self.text = text
            self.position = position
            self.children = children
        }

        init<T>(with info:T, fullMap:Bool = false)  where T:UniquePlistDataProtocol {
            self.text = info.title
            self.created = Date()
        }

        init<T>(with info: T, ancestorsById: [String : T]?, fullMap:Bool = false)  where T:UniquePlistDataProtocol {
            self.init(with: info, fullMap: fullMap)

            if ancestorsById != nil {
                let ancestors = self.ancestorNodes(with: info, availableAncestorsById: ancestorsById!, fullMap: fullMap)
                let children = self.children + ancestors
                self.children = children
            }
        }
    }
}
