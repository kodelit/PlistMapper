//
//  XMindTemplate.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 06/04/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

extension XMind {

    enum StructureClass:String {
        case logicRight = "org.xmind.ui.logic.right"
        case treeRgiht = "org.xmind.ui.tree.right"
        case none = ""
    }

    struct Template {
        struct Token {
            static let content = "##content##"
            static let timeStamp = "##timestamp##"
            static let id = "##id##"
            static let relationshipSourceNodeId = "##relationshipStartNodeId##"
            static let relationshipTargetNodeId = "##relationshipTargetNodeId##"
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
//        static let structureClassLogicRight = "org.xmind.ui.logic.right"
//        static let structureClassTreeRight = "org.xmind.ui.tree.right"

        static let container = """
        <?xml version="1.0" encoding="UTF-8" standalone="no"?>
        <xmap-content modified-by="g.maciak" timestamp="1553454457298" version="2.0" xmlns="urn:xmind:xmap:xmlns:content:2.0" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:xlink="http://www.w3.org/1999/xlink">
        <sheet id="\(Token.id)" modified-by="\(modifiedBy)" theme="\(style)" timestamp="\(Token.timeStamp)">
        \(Token.content)
        <title>\(Token.sheetName)</title>
        \(Token.relationships)
        </sheet>
        </xmap-content>
        """

        static let topic = """
        <topic \(Token.branchAttribute) id="\(Token.id)"\(Token.linkAttribute) modified-by="\(modifiedBy)"\(Token.structureClassAttribute) timestamp="\(Token.timeStamp)">\(Token.content)</topic>
        """
        static let title = "<title><![CDATA[\(Token.content)]]></title>"
        static let children = "<children>\(Token.content)</children>"
        static let topics = "<topics type=\"attached\">\(Token.content)</topics>"

        static let relationships = "<relationships>\(Token.content)</relationships>"
        static let relationship = """
        <relationship end1="\(Token.relationshipSourceNodeId)" end2="\(Token.relationshipTargetNodeId)" id="\(Token.id)" modified-by="\(modifiedBy)" timestamp="\(Token.timeStamp)">\(Token.content)</relationship>
        """

        static let branchAttribute = " branch=\"folded\""
        static let linkAttribute = " xlink:href=\"\(Token.link)\""
        static let structureClassAttribute = " structure-class=\"\(Token.content)\""
    }
}
