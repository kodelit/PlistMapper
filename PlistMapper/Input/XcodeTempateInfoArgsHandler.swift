//
//  XcodeTempateInfoArgsHandler.swift
//  PlistMapper
//
//  Created by Grzegorz on 23/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

extension Input.Arg {
    static var xcodeAllTemplates:String { return "--xcode-all-proj-templates" }
    static var xcodeSelectedTemplate:String { return "--xcode-proj-template" }
    static var xcodeTemplateInheritanceMap:String { return "--xcode-proj-template-inheritance-map" }
}

class XcodeTempateInfoArgsHandler: ArgsHandler {
    let input:Input
    let parser = XcodeProjectTemplateInfoParser()
    let generator = XcodeTemplateInfoMarkdownGenerator()
    let output:MarkdownOutput

    init() {
        let input = Input()
        self.input = input

        let outputDir = input.valueForArg(Input.Arg.outputDir) ?? input.scriptDir
        self.output = MarkdownOutput(rootDir: outputDir)
    }
    
    func handle() {
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

//            let nsDict = info.plist as NSDictionary
//            print("\(fileName): ", nsDict)

            let content = self.generator.fileContent(for: info, availableAncestorsById: templateInfos)
            output.write(content: content, fileName: fileName)
        }
    }

    func allDependenciesById(for templateIdOrName:String) -> [String: TemplateInfo] {
        let templateInfos:[String: TemplateInfo] = self.parser.itemsById()
        var result:[String: TemplateInfo] = [:]
        if let selected = templateInfos[templateIdOrName]
            ?? templateInfos.first(where: { $0.value.templateName == templateIdOrName })?.value {
            result[selected.identifier] = selected

            if let ancestors = selected.ancestors() {
                for ancestor in ancestors {
                    result.merge(self.allDependenciesById(for: ancestor)) { (old, _) -> TemplateInfo in
                        return old
                    }
                }
            }
        }
        return result
    }
}
