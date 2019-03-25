//
//  UniquePlistDataType.swift
//  PlistMapper
//
//  Created by Grzegorz on 25/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

protocol UniquePlistDataType: PlistDataType {
    static var identifierKey:String { get }
    static var ancestorsKey:String? { get }
    var identifier:String { get }
    func ancestors() -> [String]?
}

extension UniquePlistDataType {
    func ancestors() -> [String]? {
        if let ancestorsKey = type(of:self).ancestorsKey,
            let ancestors = self.plist[ancestorsKey] as? [String] {
            return ancestors
        }
        return nil
    }
}
