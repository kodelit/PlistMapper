//
//  TemplateInfo.swift
//  PlistMapper
//
//  Created by Grzegorz on 22/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

struct TemplateInfo: UniquePlistDataType {
    static let fileExtension = "xctemplate"

    var templateName:String

    // MARK: - UniqueInfoPlistDetails
    static let identifierKey: String = "Identifier"
    static let ancestorsKey: String? = "Ancestors"
    var identifier:String

    var title: String { return templateName.replacingOccurrences(of: ".\(TemplateInfo.fileExtension)", with: "") }
    var path:String
    var plist:[String:Any]

    var ancestors: [TemplateInfo]? = nil

    // MARK: - Init
    init?(path:String, plist:[String:Any]) {
        guard let id = plist[TemplateInfo.identifierKey] as? String else {
            return nil
        }

        let components = path.components(separatedBy: "/")
        guard components.count > 2 else {
                return nil
        }

        let name = components[components.count - 2]
        guard !name.isEmpty else {
            return nil
        }

        self.identifier = id
        self.path = path
        self.templateName = name
        self.plist = plist
    }

    init?(path:String) {
        guard let plist = NSDictionary(contentsOfFile: path) as? [String: Any] else {
            return nil
        }
        self.init(path: path, plist: plist)
    }

    func outputFileName() -> String? {
        return title
    }
}

