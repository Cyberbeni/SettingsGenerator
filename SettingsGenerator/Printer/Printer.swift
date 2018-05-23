//
//  Printer.swift
//  SettingsGenerator
//
//  Created by Benedek Kozma on 2018. 05. 23..
//  Copyright © 2018. Benedek Kozma. All rights reserved.
//

import Foundation

final class Printer {
    static let shared = Printer()
    
    private init() {}
    
    private var printables = [PrintableObject]()
    private var header: String = """
//
// Settings.swift
//

import Foundation

struct Settings {

"""
    private var footer: String = """

}
"""

    public func add(_ printable: PrintableObject) {
        printables.append(printable)
    }
    
    public func writeToFile(_ fileUrl: URL) {
        var outputString = self.header
        printables.forEach { (printable) in
            outputString.append(printable.description)
        }
        outputString.append(footer)
        
        outputString = outputString.replacingOccurrences(of: "\t", with: "    ")
        
        do {
            try outputString.write(toFile: fileUrl.path, atomically: true, encoding: .utf8)
        } catch {
            print("error writing to output file")
            exit(1)
        }
    }
}
