//
//  MetadataProvider+Dictionary.swift
//  WeatherDebug
//

import NodeKit

extension Dictionary: MetadataProvider where Key == String, Value == String {
    
    public func metadata() -> [String: String] {
        return self
    }
}
