//
//  XMindNode+Link.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 25/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

extension XMind.Node {

    /// !!!: Link DEPENDS ON Generate Xcode Template Descritpions
    var link:String? {
        var cd:String = ""
        if let url = URL(string: XMindOutput.outputDirName) {
            let componentsCount = url.pathComponents.count
            cd = String(repeating: "../", count: componentsCount)
        }

        let markdownOutput = MarkdownOutput()
        let markdownRelativePath = markdownOutput.outputRelativePath(for: self.text)
        let path = (cd as NSString).appendingPathComponent(markdownRelativePath)
        if FileManager.default.fileExists(atPath: markdownOutput.outputFilePath(for: self.text)) {
            return "file:" + path.escapedPath()
        }
        return nil
    }
}
