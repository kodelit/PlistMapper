//
//  Date+Timestamp.swift
//  PlistMapper
//
//  Created by Grzegorz Maciak on 25/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

extension Date {
    func timestampString() -> String {
        let ts = self.timeIntervalSince1970 * 1000
        let string = String(format: "%.0f", ts)
        return string
    }
}
