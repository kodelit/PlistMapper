//
//  GenerateXcodeTempateFlatMapTask.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 07/04/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

struct XMindFlatMapGenerator: XMindGeneratorProtocol {
    var fullMap:Bool = true
    var ancestorsFolded:Bool = true
    var foldDeepNodes:Bool = true

    func fileContent<T>(for info:PlistDataProtocol, availableAncestorsById:[String: T]?) -> String where T:UniquePlistDataProtocol {
        guard var uniqueInfo = info as? T else {
            return ""
        }
        if let templates = availableAncestorsById {
            uniqueInfo.loadAncestorsTree(with: templates)
        }

        let inheritanceInfo = uniqueInfo.flatMapOfInheritance().reversed()
        var rootNode = Node(value: uniqueInfo.title)
        rootNode.structureClass = .treeRgiht
        rootNode.children = inheritanceInfo.map { (info) -> Node in
            var node = Node(with: info, ancestorsById: nil, fullMap: self.fullMap)
            node.structureClass = .logicRight
            return node
        }
        return fileContent(for: rootNode)
    }
}

struct GenerateXcodeTempateFlatMapTask: XcodeTempateInfoTask {
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
                let generator = XMindFlatMapGenerator()
                let content = generator.fileContent(for: info, availableAncestorsById: templatesById)

                let output = XMindOutput()
                let outputFileName = fileName + " Flat Map"
                output.write(content: content, fileName: outputFileName)
            }
        }
    }
}
