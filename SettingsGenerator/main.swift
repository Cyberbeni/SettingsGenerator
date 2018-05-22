//
//  main.swift
//  SettingsGenerator
//
//  Created by Benedek Kozma on 2018. 05. 22..
//  Copyright © 2018. Benedek Kozma. All rights reserved.
//

import Foundation

let argCount = CommandLine.argc

if argCount != 2 {
    print("Usage: 'settingsGenerator path_to_plist'")
    exit(-1)
}

let plistPath = CommandLine.arguments[1]
let url = URL(fileURLWithPath: plistPath)

let dictionary = NSDictionary(contentsOfFile: url.path)
let preferences = dictionary?["PreferenceSpecifiers"] as? NSArray

if preferences == nil {
    print("Invalid file path")
    exit(-1)
}

MultiValueParser.parse(preferences!)

Printer.shared.writeToFile()
