//
//  OutputType.swift
//  PlistMapper
//
//  Created by Grzegorz on 23/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

protocol OutputType {
    var rootDir:String { get }
    var outputDirName:String { get }
    var outputDir:String { get }
    init(rootDir:String)

    func reset() -> Bool
    func write(content:String, fileName:String)
}

extension OutputType {
    var outputDir:String {
        return self.path(for: outputRelativePath(for: "", fileExtension: nil))
    }

    /// removes and creates output dir again deleting all previous content
    func reset() -> Bool {
        let fileManager = FileManager.default
        let doesDirExist = fileManager.fileExists(atPath: outputDir)

        // Remove old details dir if it exists
        if doesDirExist {
            do {
                try fileManager.removeItem(atPath: outputDir)
            }catch{
                print("Could not remove `/\(outputDirName) dir", error)
            }
        }

        if !fileManager.fileExists(atPath: outputDir) {
            do {
                try fileManager.createDirectory(atPath: outputDir, withIntermediateDirectories: true, attributes: nil)
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
            try content.write(toFile: filePath, atomically: true, encoding: .utf8)
        }catch{
            print("Failed to save content of file `\(fileName)`:",error)
        }
    }

    func outputRelativePath(for fileName:String, fileExtension:String? = Markdown.fileExtension) -> String {
        let fileExtension = fileExtension != nil ? ".\(fileExtension!)" : ""
        return "\(outputDirName)/\(fileName)\(fileExtension)"
    }

    func path(for fileName:String) -> String {
        let rootDir = self.rootDir as NSString
        let filePath = rootDir.appendingPathComponent(fileName) as String
        return filePath
    }
}
