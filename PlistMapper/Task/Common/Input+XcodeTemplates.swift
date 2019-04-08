//
//  Input+XcodeTemplates.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 26/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

extension Input.Arg {
    static var xcodeSelectedTemplate:String { return "--xcode-proj-template" }
    static var xcodeTemplateInheritanceMap:String { return "--xcode-proj-template-inheritance-map" }
    static var skipMergingOptions:String { return "--skip-merging-combined-options" }
}

extension Input {
    static var shouldMapAllXcodeTemplates:Bool {
        return self.selectedTemplate == nil
    }

    /// Selected template id or name form command line param
    static var selectedTemplate:String? {
        return Input.valueForArg(Input.Arg.xcodeSelectedTemplate)
    }

    static var shouldSkipMergingOptions:Bool {
        return Input.boolForArg(Input.Arg.skipMergingOptions)
    }
}
