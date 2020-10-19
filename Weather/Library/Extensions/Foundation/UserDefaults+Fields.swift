//
//  UserDefaults+Fields.swift
//  Weather
//
//  Created by Александр Кравченков on 19.10.2020.
//

import Foundation

extension UserDefaults {

    var isNotFirstLaunch: Bool {
        get {
            return self.bool(forKey: #function)
        } set {
            self.set(newValue, forKey: #function)
        }
    }
}
