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

    static var scriptPath:String { return CommandLine.arguments.first! }

    static var scriptDir:String {
        let scriptPath = CommandLine.arguments.first!
        var dirUrl = URL(string: scriptPath)!
        dirUrl.deleteLastPathComponent()
        let scriptDir = dirUrl.absoluteString
        return scriptDir
    }

    static func boolForArg(_ name:String) -> Bool {
        if let value = self.valueForArg(name) {
            switch value.lowercased() {
            case "false", "no", "0":
                return false
            default:
                return true
            }
        }
        let isDefined = CommandLine.arguments.contains(name)
        return isDefined
    }

    static func valueForArg(_ name:String) -> String? {
        let arguments = CommandLine.arguments
        if let index = arguments.firstIndex(of: name),
            arguments.count > index + 1 {
            let value = arguments[index + 1]
            return value
        }
        return nil
    }
}
