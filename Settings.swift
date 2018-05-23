//
// Settings.swift
//

import Foundation

struct Settings {

    enum DefaultBackendServer: String {
        case test = "1"
        case dev = "0"

        private static let key = "defaultBackendServer"
        private static let defaultValue: DefaultBackendServer = .test

        static var selectedValue: DefaultBackendServer {
            let value = UserDefaults.standard.object(forKey: key) as? String
            if let value = value {
                return DefaultBackendServer(rawValue: value) ?? defaultValue
            } else {
                return defaultValue
            }
        }
    }

    enum DefaultNavigationApp: Int {
        case chooseFromAvailableApps = 0
        case maps = 1
        case googleMaps = 2
        case waze = 3

        private static let key = "defaultNavigationApp"
        private static let defaultValue: DefaultNavigationApp = .chooseFromAvailableApps

        static var selectedValue: DefaultNavigationApp {
            let value = UserDefaults.standard.object(forKey: key) as? Int
            if let value = value {
                return DefaultNavigationApp(rawValue: value) ?? defaultValue
            } else {
                return defaultValue
            }
        }
    }

}