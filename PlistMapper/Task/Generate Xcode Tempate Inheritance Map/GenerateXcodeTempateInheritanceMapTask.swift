//
//  GenerateXcodeTempateInheritanceMapTask.swift
//  PlistMapper
//
//  Created by Grzegorz on 23/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

struct GenerateXcodeTempateInheritanceMapTask: XcodeTempateInfoTask {
    let input:Input
    let parser = XcodeProjectTemplateInfoParser()
    var generators:[TextContentGenerator]
    var outputs:[OutputType]

    init() {
        let input = Input()
        self.input = input

        self.generators = [XMindGenerator(), FreeMindGenerator()]

        let outputDir = input.valueForArg(Input.Arg.outputDir) ?? input.scriptDir
        self.outputs = [XMindOutput(rootDir: outputDir), FreeMindOutput(rootDir: outputDir)]
    }

    func start() {
        guard let output = self.outputs.first, output.reset() else {
            assertionFailure()
            return
        }


        let shouldGenerateMindMap = self.input.boolForArg(Input.Arg.xcodeSelectedTemplate)

        if shouldGenerateMindMap, let selectedTemplate = self.input.valueForArg(Input.Arg.xcodeSelectedTemplate) {
            let templatesById = self.allDependenciesById(for: selectedTemplate)

            if let info = self.templateInfo(for: selectedTemplate, availableTemplatesById: templatesById),
                let fileName = info.outputFileName()
            {
                for index in 0...1  {
                    let generator = self.generators[index]
                    let content = generator.fileContent(for: info, availableAncestorsById: templatesById)

                    let output = self.outputs[index]
                    output.write(content: content, fileName: fileName)
                }
            }
        }
    }
}
