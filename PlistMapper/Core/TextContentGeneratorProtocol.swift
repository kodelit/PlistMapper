//
//  TextContentGenerator.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 23/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

protocol TextContentGeneratorProtocol {
    func fileContent<T>(for info:PlistDataProtocol, availableAncestorsById:[String: T]?) -> String where T:UniquePlistDataProtocol
    func rowIndentation(for level:Int) -> String
}

extension TextContentGeneratorProtocol {
    func rowIndentation(for level:Int) -> String {
        return String(repeating: "\t", count: level)
    }
}
