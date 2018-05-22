//
//  MultiValueParser.swift
//  SettingsGenerator
//
//  Created by Benedek Kozma on 2018. 05. 22..
//  Copyright © 2018. Benedek Kozma. All rights reserved.
//

import Foundation

final class MultiValueParser: Parser {
    static let type = "PSMultiValueSpecifier"
    
    static func parse(_ preferences: NSArray) {
        let multiValues = MultiValueParser.filter(preferences)
        
        for element in multiValues {
            if let dictionary = element as? NSDictionary {
                let defaultValue = dictionary["DefaultValue"]
                switch defaultValue {
                case let value as Int:
                    print("int", value)
                case let value as String:
                    print("string", value)
                default:
                    print("unsupported type")
                }
            }
        }
    }
}
