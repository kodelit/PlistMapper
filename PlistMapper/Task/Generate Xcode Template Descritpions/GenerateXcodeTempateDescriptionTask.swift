//
//  XcodeTempateInfoArgsHandler.swift
//  PlistMapper
//
//  Created by Grzegorz on 23/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

class GenerateXcodeTempateDescriptionTask: XcodeTempateInfoTask {
    let parser:XcodeProjectTemplateInfoParser
    var generator:TextContentGenerator
    var output:OutputType

    init(parser:XcodeProjectTemplateInfoParser) {
        self.parser = parser
        self.generator = XcodeTemplateInfoMarkdownGenerator()
        self.output = MarkdownOutput()
    }
    
    func start() {
        let selectedTemplate = Input.selectedTemplate
        let isSelectedSingleTemplate = selectedTemplate != nil

        var templateInfos:[String: TemplateInfo] = [:]
        if isSelectedSingleTemplate {
            templateInfos = self.allDependenciesById(for: selectedTemplate!)
        }else{
            templateInfos = parser.itemsById()
        }

        for (_, info) in templateInfos {
            guard let fileName = info.outputFileName() else {
                continue
            }

            let content = self.generator.fileContent(for: info, availableAncestorsById: templateInfos)
            output.write(content: content, fileName: fileName)
        }

        if isSelectedSingleTemplate,
            let info = self.templateInfo(for: selectedTemplate!, availableTemplatesById: templateInfos) {
            var plist = info.plist

        }
    }
}
