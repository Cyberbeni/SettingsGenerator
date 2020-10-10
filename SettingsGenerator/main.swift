//
//  main.swift
//  SettingsGenerator
//
//  Created by Benedek Kozma on 2018. 05. 22..
//  Copyright © 2018. Benedek Kozma. All rights reserved.
//

import Foundation
import ArgumentParser

struct SettingsGenerator: ParsableCommand {
	@Argument(help: "Path for the settings.bundle plist", completion: .file())
	var plistPath: String
	
	@Argument(help: "Path for the output file", completion: .file())
	var outputPath: String
	
	func run() throws {
		let inputUrl = URL(fileURLWithPath: plistPath)
		let outputUrl = URL(fileURLWithPath: outputPath)
		
		let dictionary = NSDictionary(contentsOfFile: inputUrl.path)
		guard let preferences = dictionary?["PreferenceSpecifiers"] as? NSArray
		else {
			throw ValidationError("Invalid input path")
		}
		
		MultiValueParser.parse(preferences)
		
		Printer.shared.writeToFile(outputUrl)
	}
}

SettingsGenerator.main()
