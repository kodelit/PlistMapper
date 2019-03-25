//
//  XMindNode+Link.swift
//  PlistMapper
//
//  Created by Grzegorz on 25/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

extension XMind.Node {

    /// !!!: Link DEPENDS ON Generate Xcode Template Descritpions
    var link:String {
        return "file:../\(MarkdownOutput.outputDirName)/\(self.text).\(Markdown.fileExtension)".escapedPath()
    }
}
