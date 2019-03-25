//
//  XcodeTempateInfoTask.swift
//  PlistMapper
//
//  Created by Grzegorz on 25/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

extension Input.Arg {
    static var xcodeAllTemplates:String { return "--xcode-all-proj-templates" }
    static var xcodeSelectedTemplate:String { return "--xcode-proj-template" }
    static var xcodeTemplateInheritanceMap:String { return "--xcode-proj-template-inheritance-map" }
}

protocol XcodeTempateInfoTask: Task {
    var parser:XcodeProjectTemplateInfoParser { get }
}

extension XcodeTempateInfoTask {
    func templateInfo(for templateIdOrName:String, availableTemplatesById:[String: TemplateInfo]) -> TemplateInfo? {
        if let selected = availableTemplatesById[templateIdOrName]
            ?? availableTemplatesById.first(where: { $0.value.templateName == templateIdOrName })?.value
        {
            return selected
        }
        return nil
    }

    func allDependenciesById(for templateIdOrName:String) -> [String: TemplateInfo] {
        let templatesById:[String: TemplateInfo] = self.parser.itemsById()
        var result:[String: TemplateInfo] = [:]
        if let selected = self.templateInfo(for: templateIdOrName, availableTemplatesById: templatesById) {
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
