//
//  Localize.swift
//  CodeBase
//
//  Created by Ho Si Tuan on 04/05/2022.
//

import UIKit
import Foundation

protocol Localizable {
    func applyLocalize()
}

enum Language {
    case english
    case japanese
    
    init?(code: String) {
        switch code {
        case "en":      self = .english
        case "ja":      self = .japanese
        default:        return nil
        }
    }
    
    var code: String {
        switch self {
        case .english:   return "en"
        case .japanese:  return "ja"
        }
    }
    
    var name: String {
        switch self {
        case .english:   return "English"
        case .japanese:  return "日本語"
        }
    }
    
    var locale: Locale {
        return Locale(identifier: code)
    }
}

extension Language {
    static let languageChangeNotification = Notification.Name("HOLanguageDidChangeNotification")
    
    /// Current language key
    private static let currentLanguageCodeKey = "CurrentLanguageCodeKey"
    
    static var currentLanguage: Language {
        let defaults = UserDefaults.standard
        if let code = defaults.object(forKey: currentLanguageCodeKey) as? String,
            let lang = Language(code: code) {
            return lang
        }
        return defaultLanguage
    }
    
    static var defaultLanguage: Language {
        let locale = Locale(identifier: Locale.preferredLanguages.first ?? Locale.current.identifier)
        if let lang = Language(code: locale.identifier) {
            return lang
        }
        return .japanese
    }
    
    static func setCurrentLanguage(_ lang: Language) {
        if currentLanguage != lang {
            let defaults = UserDefaults.standard
            defaults.set(lang.code, forKey: currentLanguageCodeKey)
            //defaults.synchronize()
            NotificationCenter.default.post(name: languageChangeNotification, object: nil)
            //BaseAPIServiceKit.shared.HTTPAdditionalHeaders["Accept-Language"] = lang.code
        }
    }
    
    static func resetCurrentLanguageToDefault() {
        setCurrentLanguage(defaultLanguage)
    }
}

extension String {
    func localized(_ value: String? = nil, tableName: String? = nil, in bundle: Bundle = .main) -> String {
        if let path = bundle.path(forResource: Language.currentLanguage.code, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: self, value: value, table: tableName)
        }
        return self
    }
    
    func localizedFormat(arguments: CVarArg..., value: String? = nil, tableName: String? = nil, in bundle: Bundle = .main) -> String {
        return String(format: localized(value, tableName: tableName, in: bundle), arguments: arguments)
    }
    
    var localized: String {
        return localized(in: .main)
    }
    
    func localizedFormat(_ arguments: CVarArg...) -> String {
        return String(format: localized, arguments: arguments)
    }
}

