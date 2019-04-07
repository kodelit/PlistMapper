//
//  GenerateXcodeTempateFullMapTask.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 26/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

struct XMindFullMapGenerator: XMindGeneratorProtocol {
    var fullMap:Bool = true
    var ancestorsFolded:Bool = true
    var foldDeepNodes:Bool = true
}

struct GenerateXcodeTempateFullMapTask: XcodeTempateInfoTask {
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
                let generator = XMindFullMapGenerator()
                let content = generator.fileContent(for: info, availableAncestorsById: templatesById)

                let output = XMindOutput()
                let outputFileName = fileName + " Full Map"
                output.write(content: content, fileName: outputFileName)
            }
        }
    }
}
