//
//  OutputType.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 23/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

protocol OutputType {
    static var outputDirName:String { get }
    static var outputFileExt:String { get }

    var outputDir:String { get }
    func write(content:String, fileName:String)
}

struct Output:OutputType {
    static var outputDirName = ""
    static var outputFileExt: String { fatalError("This output is not desinged for writing") }
    func write(content:String, fileName:String) { fatalError("This output is not desinged for writing") }
}

extension OutputType {
    static var rootDir:String {
        return Input.valueForArg(Input.Arg.outputDir) ?? Input.scriptDir
    }

    var outputDir:String {
        return self.outputFilePath(for: "", fileExtension: nil)
    }

    /// Removes and creates output dir again deleting all previous content
    static func reset(dir:String? = nil) -> Bool {
        let fileManager = FileManager.default
        let targetDir = dir ?? rootDir
        let doesDirExist = fileManager.fileExists(atPath: targetDir)

        // Remove old details dir if it exists
        if doesDirExist {
            do {
                try fileManager.removeItem(atPath: targetDir)
            }catch{
                print("Could not remove `/\(targetDir) dir", error)
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
        let filePath = outputFilePath(for: fileName)
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
        return (Self.outputDirName as NSString).appendingPathComponent("\(fileName)\(fileExtension)") 
    }

    func outputFilePath(for fileName:String, fileExtension:String? = outputFileExt) -> String {
        let rootDir = Self.rootDir as NSString
        let filePath = rootDir.appendingPathComponent(self.outputRelativePath(for: fileName, fileExtension: fileExtension)) as String
        return filePath
    }
}
