//
//  GenerateXcodeTempateInheritanceMapTask.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 23/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

struct XMindInheritanceMapGenerator: XMindGeneratorProtocol {
    var fullMap:Bool = false
    var ancestorsFolded:Bool = false
    var foldDeepNodes:Bool = false
}

struct GenerateXcodeTempateInheritanceMapTask: XcodeTempateInfoTask {
    let parser:XcodeProjectTemplateInfoParser

    init(parser:XcodeProjectTemplateInfoParser) {
        self.parser = parser
    }

    func start() {
        if let selectedTemplate = Input.selectedTemplate {
            let templatesById = self.allDependenciesById(for: selectedTemplate)

            if let info = self.templateInfo(for: selectedTemplate, availableTemplatesById: templatesById),
                let fileName = info.outputFileName()
            {
                let generators:[TextContentGeneratorProtocol] = [XMindInheritanceMapGenerator(), FreeMindGenerator()]
                let outputs:[OutputType] = [XMindOutput(), FreeMindOutput()]

                for index in 0..<generators.count  {
                    let generator = generators[index]
                    let content = generator.fileContent(for: info, availableAncestorsById: templatesById)

                    let output = outputs[index]
                    let outputFileName = fileName + " Inheritance Map"
                    output.write(content: content, fileName: outputFileName)
                }
            }
        }
    }
}
