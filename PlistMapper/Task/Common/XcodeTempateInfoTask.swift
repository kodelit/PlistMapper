//
//  XcodeTempateInfoTask.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 25/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

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

            if let ancestors = selected.ancestorsIds() {
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
