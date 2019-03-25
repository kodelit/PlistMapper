//
//  MindMapNodeType.swift
//  PlistMapper
//
//  Created by Grzegorz on 25/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

protocol MindMapNodeType {
    var id:String { get }
    var text:String { get }
    var children:[Self] { get set }

    init(with info:UniquePlistDataType)
    init(with info:UniquePlistDataType, ancestorsById:[String: UniquePlistDataType]?)
}

extension MindMapNodeType {

    func ancestorNodes(with info:UniquePlistDataType, availableAncestorsById:[String: UniquePlistDataType]) -> [Self] {
        if let ancestors = info.ancestors() {
            let children = ancestors.reduce(into: [Self](), { (result, identifier) in
                if let ancestorInfo = availableAncestorsById[identifier] {
                    let child = Self(with: ancestorInfo, ancestorsById: availableAncestorsById)
                    result.append(child)
                }
            })
            return children
        }
        return []
    }
}
