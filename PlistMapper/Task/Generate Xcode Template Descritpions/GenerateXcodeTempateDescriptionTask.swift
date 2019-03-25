//
//  XcodeTempateInfoArgsHandler.swift
//  PlistMapper
//
//  Created by Grzegorz on 23/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

struct XcodeTemplateInfoMarkdownGenerator: MarkdownGenerator {}
//struct XcodeTemplateSummaryMarkdownGenerator: MarkdownGenerator {}

struct GenerateXcodeTempateDescriptionTask: XcodeTempateInfoTask {
    let input:Input
    let parser = XcodeProjectTemplateInfoParser()
    var generator:TextContentGenerator
    var output:OutputType

    init() {
        let input = Input()
        self.input = input

        self.generator = XcodeTemplateInfoMarkdownGenerator()

        let outputDir = input.valueForArg(Input.Arg.outputDir) ?? input.scriptDir
        self.output = MarkdownOutput(rootDir: outputDir)
    }
    
    func start() {
        guard output.reset() else {
            assertionFailure()
            return
        }

        let shouldMapAllXcodeTemplates = self.input.boolForArg(Input.Arg.xcodeAllTemplates)

        var templateInfos:[String: TemplateInfo] = [:]
        if shouldMapAllXcodeTemplates {
            templateInfos = parser.itemsById()
        }
        // if Should Map Signle Xcode Template
        else if let selectedTemplate = self.input.valueForArg(Input.Arg.xcodeSelectedTemplate) {
            templateInfos = self.allDependenciesById(for: selectedTemplate)
        }

        for (_, info) in templateInfos {
            guard let fileName = info.outputFileName() else {
                continue
            }

            let content = self.generator.fileContent(for: info, availableAncestorsById: templateInfos)
            output.write(content: content, fileName: fileName)
        }
    }
}
