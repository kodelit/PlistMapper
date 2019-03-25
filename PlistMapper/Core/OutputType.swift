//
//  OutputType.swift
//  PlistMapper
//
//  Created by Grzegorz on 23/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

protocol OutputType {
    static var outputDirName:String { get }
    static var outputFileExt:String { get }

    var rootDir:String { get }
    var outputDir:String { get }
    init(rootDir:String)

    func reset(dir:String?) -> Bool
    func write(content:String, fileName:String)
}

extension OutputType {
    var outputDir:String {
        return self.path(for: outputRelativePath(for: "", fileExtension: nil))
    }

    /// removes and creates output dir again deleting all previous content
    func reset(dir:String? = nil) -> Bool {
        let fileManager = FileManager.default
        let targetDir = dir ?? outputDir
        let doesDirExist = fileManager.fileExists(atPath: targetDir)

        // Remove old details dir if it exists
        if doesDirExist {
            do {
                try fileManager.removeItem(atPath: targetDir)
            }catch{
                print("Could not remove `/\(Self.outputDirName) dir", error)
            }
        }

        if !fileManager.fileExists(atPath: targetDir) {
            do {
                try fileManager.createDirectory(atPath: targetDir, withIntermediateDirectories: true, attributes: nil)
                return true
            }catch{
                print(error)
            }
        }
        return false
    }

    func write(content:String, fileName:String) {
        let filePath = path(for: outputRelativePath(for: fileName))
        do{
            if FileManager.default.fileExists(atPath: filePath) {
                try FileManager.default.removeItem(atPath: filePath)
            }
            try content.write(toFile: filePath, atomically: true, encoding: .utf8)
        }catch{
            print("Failed to save content of file `\(fileName)`:",error)
        }
    }

    func outputRelativePath(for fileName:String, fileExtension:String? = outputFileExt) -> String {
        let fileExtension = fileExtension != nil ? ".\(fileExtension!)" : ""
        return "\(Self.outputDirName)/\(fileName)\(fileExtension)"
    }

    func path(for fileName:String) -> String {
        let rootDir = self.rootDir as NSString
        let filePath = rootDir.appendingPathComponent(fileName) as String
        return filePath
    }
}
