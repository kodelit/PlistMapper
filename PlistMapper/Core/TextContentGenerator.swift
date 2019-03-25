//
//  TextContentGenerator.swift
//  PlistMapper
//
//  Created by Grzegorz on 23/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

protocol TextContentGenerator {
    func fileContent(for info:PlistDataType, availableAncestorsById:[String: UniquePlistDataType]?) -> String
    func rowIndentation(for level:Int) -> String
}

extension TextContentGenerator {
    func rowIndentation(for level:Int) -> String {
        return String(repeating: "\t", count: level)
    }
}
