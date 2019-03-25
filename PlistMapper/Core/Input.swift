//
//  Input.swift
//  PlistMapper
//
//  Created by Grzegorz on 23/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

struct Input {
    struct Arg {
        static let outputDir:String = "--output"
    }

    let arguments = CommandLine.arguments
    var scriptPath:String { return arguments.first! }

    var scriptDir:String {
        let scriptPath = self.arguments.first!
        var dirUrl = URL(string: scriptPath)!
        dirUrl.deleteLastPathComponent()
        let scriptDir = dirUrl.absoluteString
        return scriptDir
    }

    func boolForArg(_ name:String) -> Bool {
        if let value = self.valueForArg(name) {
            switch value.lowercased() {
            case "false", "no", "0":
                return false
            default:
                return true
            }
        }
        let isDefined = self.arguments.contains(name)
        return isDefined
    }

    func valueForArg(_ name:String) -> String? {
        let arguments = self.arguments
        if let index = arguments.firstIndex(of: name),
            arguments.count > index + 1 {
            let value = arguments[index + 1]
            return value
        }
        return nil
    }
}
