//
//  MultiValueObject.swift
//  SettingsGenerator
//
//  Created by Benedek Kozma on 2018. 05. 23..
//  Copyright © 2018. Benedek Kozma. All rights reserved.
//

import Foundation

final class MultiValueObject<ValueType: CaseLineProvider & Equatable>: PrintableObject {
    var key: String
    var defaultValue: ValueType
    var values: [String: ValueType]
    
    init(defaultValue: ValueType, dictionary: NSDictionary) {
        self.defaultValue = defaultValue
        self.key = dictionary[Keys.Key.rawValue] as! String
        self.values = [String: ValueType]()
        let titles = dictionary[Keys.Titles.rawValue] as? [String]
        let values = dictionary[Keys.Values.rawValue] as? [ValueType]
        titles?.enumerated().forEach({ (title) in
            self.values[title.element] = values?[title.offset]
        })
    }
    
    var description: String
    {
        var description = "\n\tenum \(key.capitalizedFirstLetter): \(ValueType.self) {\n"
        self.values.forEach { (body) in
            description.append(body.value.lineForCase(key: body.key))
        }
        description.append("\n\t\tprivate static let key = \"\(key)\"\n")
        description.append("\t\tprivate static let defaultValue: \(key.capitalizedFirstLetter) = .\(values.first(where: { $0.value == defaultValue })!.key.camelCasedString)\n")
        description.append("""

        static var selectedValue: \(key.capitalizedFirstLetter) {
            get {
                let value = UserDefaults.standard.object(forKey: key) as? \(ValueType.self)
                if let value = value {
                    return \(key.capitalizedFirstLetter)(rawValue: value) ?? defaultValue
                } else {
                    return defaultValue
                }
            }
            set {
                UserDefaults.standard.set(newValue.rawValue, forKey: key)
            }
        }

""")
        description.append("\t}\n")
        return description
    }
}

protocol CaseLineProvider: CustomStringConvertible {
    func lineForCase(key: String) -> String
}

extension String: CaseLineProvider {
    func lineForCase(key: String) -> String {
        return "\t\tcase \(key.camelCasedString) = \"\(self)\"\n"
    }
}

extension Int: CaseLineProvider {
    func lineForCase(key: String) -> String {
        return "\t\tcase \(key.camelCasedString) = \(self)\n"
    }
}

extension Double: CaseLineProvider {
    func lineForCase(key: String) -> String {
        return "\t\tcase \(key.camelCasedString) = \(self)\n"
    }
}
