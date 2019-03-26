//
//  String+Path.swift
//  PlistMapper
//
//  Created by Grzegorz on 25/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

extension String {
    func escapedPath() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed) ?? self
    }

    func escapedXML() -> String {
        return replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "\"", with: "&quot;")
            .replacingOccurrences(of: "'", with: "&#39;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "<", with: "&lt;")
    }
}
