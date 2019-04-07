//
//  PlistParserType.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 22/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

struct Plist {
    static let fileExtension = "plist"
}

public protocol PlistParserType {
    associatedtype Item

    var items:[Item] { get }
    func parsePlist(filePath:String) -> Item?
    func parsePlists(filePaths:[String]) -> [Item]
}

extension PlistParserType where Item: PlistDataProtocol {
    func parsePlist(filePath:String) -> Item? {
        let path = (filePath as NSString).resolvingSymlinksInPath as String
        guard let plist = NSDictionary(contentsOfFile: path) as? [String: Any],
            let info = Item(path: filePath, plist: plist) else {
                return nil
        }
        return info
    }

    func parsePlists(filePaths:[String]) -> [Item] {
        let infoById: [Item] =
            filePaths.compactMap { (filePath) -> Item? in
                return self.parsePlist(filePath: filePath)
        }
        return infoById
    }
}

extension PlistParserType where Item: UniquePlistDataProtocol {
    func itemsById() -> [String: Item] {
        return self.items.reduce(into: [String: Item](), { (result, item) in
            result[item.identifier] = item
        })
    }
}
