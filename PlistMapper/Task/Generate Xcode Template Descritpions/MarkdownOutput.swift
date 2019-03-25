//
//  MarkdownOutput.swift
//  PlistMapper
//
//  Created by Grzegorz on 23/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

struct MarkdownOutput: OutputType {
    static let outputDirName = "Markdowns"
    static let outputFileExt = Markdown.fileExtension
    
    let rootDir:String

    init(rootDir:String) {
        self.rootDir = rootDir
    }
}
