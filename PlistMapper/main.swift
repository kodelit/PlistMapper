//
//  main.swift
//  PlistMapper
//
//  Created by Grzegorz on 22/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

// This code is distributed under the terms and conditions of the MIT License:

// Copyright © 2019 kodelit.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


import Foundation

guard CommandLine.arguments.count > 1 else {
    print("Missing argument")
    exit(EXIT_FAILURE)
}

//let arguments = CommandLine.arguments
//let scriptPath = arguments.first!
//
//var dirUrl = URL(string: scriptPath)!
//dirUrl.deleteLastPathComponent()
//let outputRootDir = dirUrl.absoluteString

//let markdownOutput = MarkdownOutput(rootDir: outputRootDir)
let handlers:[ArgsHandler] = [XcodeTempateInfoArgsHandler()]
//let markdownsDir = markdownOutput.outputDir

// MARK: - Main

for handler in handlers {
    handler.handle()
}
