//
//  FreeMindOutput.swift
//  PlistMapper
//
//  Created by Grzegorz on 23/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

struct FreeMindOutput: OutputType {
    static let outputDirName = "MindMaps"
    static let outputFileExt = FreeMind.fileExtension

    let rootDir: String

    init(rootDir:String) {
        self.rootDir = rootDir
    }
}
