//
//  String+.swift
//  CodeBase
//
//  Created by Ho Si Tuan on 04/05/2022.
//

import Foundation
import UIKit

public extension String {
    var isValidURL: Bool {
        if let url = URL(string: self) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    func trimmed() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func trimmedAndLowercased() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).lowercased()
    }
    
    func isValidEmail() -> Bool {
        let laxString = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let emailTest : NSPredicate = NSPredicate(format:"SELF MATCHES %@", laxString)
        return emailTest.evaluate(with: self)
    }
    
    func getLinks() -> [NSRange] {
        let input = self
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        var result = [NSRange]()
        if let matches = detector?.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count)) {
            for match in matches {
                if let range = Range(match.range, in: input), String(input[range]).isValidURL {
                    result.append(match.range)
                }
            }
        }
        return result
    }
    static func random(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
    func replace(at index: Int, _ newChar: Character) -> String {
        var chars = Array(self)
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }
    
    func toDate(_ format: String? = nil) -> Date? {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = format ?? "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: self)
    }
    
    static func toDate(_ dateStr: String?) -> Date {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.date(from: dateStr ?? "") ?? Date()
    }
    
    static func toInt(_ value: String?) -> Int? {
        if let value = value { return Int(value)}
        return nil
    }
}
