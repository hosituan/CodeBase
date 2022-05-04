//
//  DateFormatter+.swift
//  Golfull
//
//  Created by Hồ Sĩ Tuấn on 22/07/2021.
//

import Foundation
public extension DateFormatter {
    static func gregorianInit() -> DateFormatter {
        let dm = DateFormatter()
        dm.calendar = Calendar(identifier: .gregorian)
        dm.locale = Locale(identifier: "en_US_POSIX")
        return dm
    }
}
