//
//  FreeMindTemplate.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 06/04/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

extension FreeMind {
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
