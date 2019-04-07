//
//  MindMapNodeType.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 25/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

protocol MindMapNodeType {
    var id:String { get }
//    var text:String { get }
    var children:[Self] { get set }

    init<T>(with info:T, fullMap:Bool) where T:UniquePlistDataProtocol
    init<T>(with info:T, ancestorsById:[String: T]?, fullMap:Bool) where T:UniquePlistDataProtocol
}

extension MindMapNodeType {

    func ancestorNodes<T>(with info:T, availableAncestorsById:[String: T], fullMap:Bool) -> [Self] where T:UniquePlistDataProtocol {
        if let ancestors = info.ancestorsIds() {
            let children = ancestors.reduce(into: [Self](), { (result, identifier) in
                if let ancestorInfo = availableAncestorsById[identifier] {
                    let child = Self(with: ancestorInfo, ancestorsById: availableAncestorsById, fullMap: fullMap)
                    result.append(child)
                }
            })
            return children
        }
        return []
    }
}
