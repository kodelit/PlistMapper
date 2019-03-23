//
//  InfoPlistDetails.swift
//  PlistMapper
//
//  Created by Grzegorz on 22/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

protocol PlistDataType {
    var title:String { get }
    var path:String { get }
    var plist:[String:Any] { get }

    init?(path:String, plist:[String:Any])

    // MARK: - With default implementations
    func sourceFileNameWithExtension() -> String?
    func sourceFileName() -> String?

    func outputFileName() -> String?
}

protocol UniquePlistDataType: PlistDataType {
    static var identifierKey:String { get }
    static var ancestorsKey:String? { get }
    var identifier:String { get }
    func ancestors() -> [String]?
}

extension PlistDataType {
    func sourceFileNameWithExtension() -> String? {
        let components = path.components(separatedBy: "/")
        guard let fileName = components.last, !fileName.isEmpty else {
            return nil
        }
        return fileName
    }

    func sourceDir() -> String {
        return (path as NSString).deletingLastPathComponent as String
    }

    func sourceFileName() -> String? {
        return sourceFileNameWithExtension()?.replacingOccurrences(of: ".\(Plist.fileExtension)", with: "")
    }

    func outputFileName() -> String? {
        return self.title
    }
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
