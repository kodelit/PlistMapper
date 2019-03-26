//
//  GenerateXcodeTempateFullMapTask.swift
//  PlistMapper
//
//  Created by Grzegorz on 26/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

struct GenerateXcodeTempateFullMapTask: XcodeTempateInfoTask {
    let parser:XcodeProjectTemplateInfoParser
    var generators:[TextContentGenerator]
    var outputs:[OutputType]

    init(parser:XcodeProjectTemplateInfoParser) {
        self.parser = parser

        var xmindGenerator = XMindGenerator()
        xmindGenerator.fullMap = true
        xmindGenerator.ancestorsFolded = true

        self.generators = [xmindGenerator, FreeMindGenerator()]
        self.outputs = [XMindOutput(), FreeMindOutput()]
    }

    func start() {
        if let selectedTemplate = Input.selectedTemplate {
            let templatesById = self.allDependenciesById(for: selectedTemplate)

            if let info = self.templateInfo(for: selectedTemplate, availableTemplatesById: templatesById),
                let fileName = info.outputFileName()
            {
                // !!!: Free mind map for this task is not supported yet
                for index in 0...0  {
                    let generator = self.generators[index]
                    let content = generator.fileContent(for: info, availableAncestorsById: templatesById)

                    let output = self.outputs[index]
                    let outputFileName = fileName + " Full Map"
                    output.write(content: content, fileName: outputFileName)
                }
            }
        }
    }
}
