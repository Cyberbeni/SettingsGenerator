//
//  Parser.swift
//  SettingsGenerator
//
//  Created by Benedek Kozma on 2018. 05. 22..
//  Copyright © 2018. Benedek Kozma. All rights reserved.
//

import Foundation

protocol Parser {
    static var type: String { get }
    static func parse(_ preferences: NSArray)
    static func filter(_ preferences: NSArray) -> [Any]
}

extension Parser {
    static func filter(_ preferences: NSArray) -> [Any] {
        return preferences.filter({ (element) -> Bool in
            if let dict = element as? NSDictionary {
                return dict["Type"] as? String == Self.type
            } else {
                return false
            }
        })
    }
}
