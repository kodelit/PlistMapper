//
//  XcodeTemplateInfoMarkdownGenerator.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 26/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

struct XcodeTemplateInfoMarkdownGenerator: MarkdownGenerator {}

struct XcodeTemplateCombinedInfoMarkdownGenerator: MarkdownGenerator {

    private func identifier(of value:Any, at index:Int) -> String? {
        guard let identifier = (value as? [String: Any])?[TemplateInfo.identifierKey] as? String else {
            return nil
        }
        return "\(index): \(identifier)"
    }

    func rowsForArray(_ array:[Any], indentationLevel level:Int) -> [String] {
        var rows:[String] = []
        if let list = array as? [String] {
            for (index, value) in list.enumerated() {
                let text = self.rowForString(value, key: "\(index)", indentationLevel: level)
                rows.append(text)
            }
        }else{
            let menuAllowed = level == XcodeTemplateCombinedInfoMarkdownGenerator.noIndentationLevel + 1
            if menuAllowed {
                let keys = array.enumerated().compactMap { (index, value) -> String? in
                    return self.identifier(of: value, at: index)
                }
                let menu = self.fileMenu(with: keys)
                if menu.count > 0 {
                    rows.append("By identifier: \(menu)")
                }
            }

            for (index, value) in array.enumerated() {
                var keyRow = self.rowForKey("\(index)", indentationLevel: level)
                if menuAllowed, let identifier = self.identifier(of: value, at: index) {
                    keyRow = "\(keyRow) <span id=\"a_\(identifier)\"/>[↩](#m_\(identifier))"
                }
                rows.append(keyRow)

                let subrows = self.rows(for: value, indentationLevel: level + 1)
                rows.append(contentsOf: subrows)
            }
        }
        return rows
    }
}
