//
//  MultiValueObject.swift
//  SettingsGenerator
//
//  Created by Benedek Kozma on 2018. 05. 23..
//  Copyright © 2018. Benedek Kozma. All rights reserved.
//

import Foundation

final class MultiValueObject<ValueType: CustomStringConvertible>: PrintableObject {
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
        var description = """
    
    enum \(key.capitalizedFirstLetter): \(ValueType.self) {

"""
        self.values.forEach { (body) in
            description.append("\t\tcase \(body.key.camelCasedString) = \(body.value.description)\n")
        }
        
        description.append("\t}\n")
        return description
    }
}
