//
//  XcodeTemplateInfoParser.swift
//  PlistMapper
//
//  Created by Grzegorz on 22/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

struct XcodeProjectTemplateInfoParser: PlistParserType {
    typealias Item = TemplateInfo

    let templatePaths:[String] = {
        let contentBasePath = "/Applications/Xcode.app"
        return [
            // ios templates
            "\(contentBasePath)/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project Templates/iOS/",
            // base templates
            "\(contentBasePath)/Contents/Developer/Library/Xcode/Templates/Project Templates/",
            // user templates
            "~/Library/Developer/Xcode/Templates/Project Templates/"
        ]
    }()

    private(set) var items:[Item] = []

    init() {
        self.reload()
    }

    mutating func reload() {
        var items:[Item] = []
        for directory in templatePaths {
//            print("Loading dir:", directory)
            do {
                let path = (directory as NSString).resolvingSymlinksInPath as String

                let files = try FileManager.default.subpathsOfDirectory(atPath: path)
                let plistFiles = files
                    .filter( { (path:String) -> Bool in
                        return path.hasSuffix(".\(Plist.fileExtension)")
                    })
                    .map( { (path:String) -> String in
                        return "\(directory)\(path)"
                    })

//                print(" All:",files)
//                print(" Plists:",plistFiles)

                let infos = parsePlists(filePaths: plistFiles)
                items.append(contentsOf: infos)
            }catch{
                assertionFailure("Error: \(error)")
            }
        }
        self.items = items
    }
}
