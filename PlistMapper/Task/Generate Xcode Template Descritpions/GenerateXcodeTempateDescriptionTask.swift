//
//  XcodeTempateInfoArgsHandler.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 23/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

class GenerateXcodeTempateDescriptionTask: XcodeTempateInfoTask {
    let parser:XcodeProjectTemplateInfoParser

    init(parser:XcodeProjectTemplateInfoParser) {
        self.parser = parser
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

        let output = MarkdownOutput()
        let generator = XcodeTemplateCombinedInfoMarkdownGenerator()
        for (_, info) in templateInfos {
            guard let fileName = info.outputFileName() else {
                continue
            }

            let content = generator.fileContent(for: info, availableAncestorsById: templateInfos)
            output.write(content: content, fileName: fileName)
        }

        if isSelectedSingleTemplate,
            var info = self.templateInfo(for: selectedTemplate!, availableTemplatesById: templateInfos),
            let fileName = info.outputFileName()
        {
            info.loadAncestorsTree(with: templateInfos)
            info.plist = info.composedPlist()

            let generator = XcodeTemplateCombinedInfoMarkdownGenerator()
            let content = generator.fileContent(for: info, availableAncestorsById: templateInfos)
            let outputFileName = fileName + " Combined"
            output.write(content: content, fileName: outputFileName)
        }
    }
}
