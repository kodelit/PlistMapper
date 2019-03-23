//
//  TextContentGenerator.swift
//  PlistMapper
//
//  Created by Grzegorz on 23/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

protocol TextContentGenerator {
    func rows(for value:Any, indentationLevel:Int) -> [String]
    func fileContent(for info:PlistDataType) -> String
    func fileContent(for info:PlistDataType, availableAncestorsById:[String: UniquePlistDataType]?) -> String
}
