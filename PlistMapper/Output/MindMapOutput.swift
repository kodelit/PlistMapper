//
//  MindMapOutput.swift
//  PlistMapper
//
//  Created by Grzegorz on 23/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

struct MindMapOutput: OutputType {
    let rootDir: String
    let outputDirName = "Mindmaps"

    init(rootDir:String) {
        self.rootDir = rootDir
    }
}
