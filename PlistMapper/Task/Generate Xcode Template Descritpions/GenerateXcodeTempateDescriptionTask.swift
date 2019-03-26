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
    let parser = XcodeProjectTemplateInfoParser()
    var generator:TextContentGenerator
    var output:OutputType

    init() {
        self.generator = XcodeTemplateInfoMarkdownGenerator()
        self.output = MarkdownOutput()
    }
    
    func start() {
        let shouldMapAllXcodeTemplates = Input.boolForArg(Input.Arg.xcodeAllTemplates)

        var templateInfos:[String: TemplateInfo] = [:]
        if shouldMapAllXcodeTemplates {
            templateInfos = parser.itemsById()
        }
        // if Should Map Signle Xcode Template
        else if let selectedTemplate = Input.valueForArg(Input.Arg.xcodeSelectedTemplate) {
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
