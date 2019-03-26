//
//  Input+XcodeTemplates.swift
//  PlistMapper
//
//  Created by Grzegorz on 26/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

extension Input.Arg {
    static var xcodeAllTemplates:String { return "--xcode-all-proj-templates" }
    static var xcodeSelectedTemplate:String { return "--xcode-proj-template" }
    static var xcodeTemplateInheritanceMap:String { return "--xcode-proj-template-inheritance-map" }
}

extension Input {
    static var shouldMapAllXcodeTemplates:Bool {
        return Input.boolForArg(Input.Arg.xcodeAllTemplates)
    }

    /// Selected template id or name form command line param
    static var selectedTemplate:String? {
        return self.shouldMapAllXcodeTemplates ? nil : Input.valueForArg(Input.Arg.xcodeSelectedTemplate)
    }
}
