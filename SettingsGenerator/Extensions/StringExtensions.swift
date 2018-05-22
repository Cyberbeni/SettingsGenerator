//
//  StringExtensions.swift
//  SettingsGenerator
//
//  Created by Benedek Kozma on 2018. 05. 23..
//  Copyright © 2018. Benedek Kozma. All rights reserved.
//

import Foundation

extension String {
    var capitalizedFirstLetter: String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    var lowercasedFirstLetter: String {
        return prefix(1).lowercased() + dropFirst()
    }
    
    @discardableResult
    mutating func capitalizeFirstLetter() -> String {
        self = self.capitalizedFirstLetter
        return self
    }
    
    var camelCasedString: String {
        return self.components(separatedBy: " ")
            .map { return $0.lowercased().capitalizedFirstLetter }
            .joined()
            .lowercasedFirstLetter
    }
}
