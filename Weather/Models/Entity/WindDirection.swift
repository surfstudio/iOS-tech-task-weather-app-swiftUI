//
//  WindDirection.swift
//  WeatherDebug
//

import Foundation

enum WindDirection {

    case north
    case east
    case south
    case west

    case northEast
    case southEast
    case southWest
    case northWest

    case doubleNorthEast
    case doubleNorthWest

    case doubleSouthWest
    case doubleSouthEast

    case westNorthWest
    case westSouthWest

    case eastNorthEast
    case eastSouthEast

    // swiftlint:disable cyclomatic_complexity
    init?(degrees: Double) {
        // Информация взята из http://snowfence.umn.edu/Components/winddirectionanddegrees.htm
        switch degrees {
        case 326.25...348.75:
            self = .doubleNorthWest
        case 303.75...326.25:
            self = .northWest
        case 281.25...303.75:
            self = .westNorthWest
        case 258.75...281.25:
            self = .west
        case 236.25...258.75:
            self = .westSouthWest
        case 213.75...236.25:
            self = .southWest
        case 191.25...213.75:
            self = .doubleSouthWest
        case 168.75...191.25:
            self = .south
        case 146.25...168.75:
            self = .doubleSouthEast
        case 123.75...146.25:
            self = .southEast
        case 101.25...123.75:
            self = .eastSouthEast
        case 78.75...101.25:
            self = .east
        case 56.25...78.75:
            self = .eastNorthEast
        case 33.75...56.25:
            self = .northEast
        case 11.25 - 33.75:
            self = .doubleNorthEast
        case 348.75...360, 0...11.25:
            self = .north
        default:
            return nil
        }
        // swiftlint:enable cyclomatic_complexity
    }
}
