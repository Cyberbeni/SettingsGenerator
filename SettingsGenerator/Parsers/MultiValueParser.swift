//
//  MultiValueParser.swift
//  SettingsGenerator
//
//  Created by Benedek Kozma on 2018. 05. 22..
//  Copyright © 2018. Benedek Kozma. All rights reserved.
//

import Foundation

final class MultiValueParser: Parser {
    static let type = Types.MultiValue.rawValue
    
    static func parse(_ preferences: NSArray) {
        let multiValues = MultiValueParser.filter(preferences)
        
        for element in multiValues {
            if let dictionary = element as? NSDictionary {
                print(element)
                let values = dictionary[Keys.Values.rawValue]
                let defaultValue = dictionary[Keys.DefaultValue.rawValue]
                switch (values, defaultValue) {
                case let (_ as [Int], value as Int):
                    Printer.shared.add(MultiValueObject(defaultValue: value, dictionary: dictionary))
                case let (_ as [String], value as String):
                    Printer.shared.add(MultiValueObject(defaultValue: value, dictionary: dictionary))
                case let (_ as [Double], value as Double):
                    Printer.shared.add(MultiValueObject(defaultValue: value, dictionary: dictionary))
                default:
                    print("unsupported type")
                }
            }
        }
    }
}
