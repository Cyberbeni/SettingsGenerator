//
//  main.swift
//  SettingsGenerator
//
//  Created by Benedek Kozma on 2018. 05. 22..
//  Copyright © 2018. Benedek Kozma. All rights reserved.
//

import Foundation

let argCount = CommandLine.argc

if argCount != 3 {
    print("Usage: 'settingsGenerator path_to_plist path_to_output'")
    exit(-1)
}

let plistPath = CommandLine.arguments[1]
let inputUrl = URL(fileURLWithPath: plistPath)
let outputPath = CommandLine.arguments[2]
let outputUrl = URL(fileURLWithPath: outputPath)

let dictionary = NSDictionary(contentsOfFile: inputUrl.path)
let preferences = dictionary?["PreferenceSpecifiers"] as? NSArray

if preferences == nil {
    print("Invalid file path")
    exit(-1)
}

MultiValueParser.parse(preferences!)

Printer.shared.writeToFile(outputUrl)
