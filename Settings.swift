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
            get {
                let value = UserDefaults.standard.object(forKey: key) as? String
                return DefaultBackendServer(rawValue: value ?? defaultValue.rawValue) ?? defaultValue
            }
            set {
                UserDefaults.standard.set(newValue.rawValue, forKey: key)
            }
        }
    }

    enum DefaultNavigationApp: Double {
        case chooseFromAvailableApps = 0.0
        case maps = 1.0
        case googleMaps = 2.0
        case waze = 3.5

        private static let key = "defaultNavigationApp"
        private static let defaultValue: DefaultNavigationApp = .chooseFromAvailableApps

        static var selectedValue: DefaultNavigationApp {
            get {
                let value = UserDefaults.standard.object(forKey: key) as? Double
                return DefaultNavigationApp(rawValue: value ?? defaultValue.rawValue) ?? defaultValue
            }
            set {
                UserDefaults.standard.set(newValue.rawValue, forKey: key)
            }
        }
    }
}