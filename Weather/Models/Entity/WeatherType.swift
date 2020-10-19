//
//  WeatherType.swift
//  WeatherDebug
//

import Foundation

enum WeatherType: Int {
    case thunderstorm
    case drizzle
    case rain
    case snow
    case fog
    case clear
    case clouds
    case unknown

    init(typeId: Int) {
        switch typeId {
        case 200...299:
            self = .thunderstorm
        case 300...399:
            self = .drizzle
        case 500...599:
            self = .rain
        case 600...699:
            self = .snow
        case 741:
            self = .fog
        case 800:
            self = .clear
        case 801...899:
            self = .clouds
        default:
            self = .unknown
        }
    }
}

extension WeatherType {
    var dayAsset: ImageAsset {
        switch self {
        // FIXME: Добавить иконки для типов дождя
        case .thunderstorm, .drizzle, .rain:
            return Asset.Image.Weather.rain
        case .snow:
            return Asset.Image.Weather.snow
        case .fog:
            return Asset.Image.Weather.fog
        case .unknown:
            return Asset.Image.Weather.clouds
        case .clouds:
            return Asset.Image.Weather.sunCloud
        case .clear:
            return Asset.Image.Weather.sun
        }
    }

    var nightAsset: ImageAsset {
        switch self {
        // FIXME: Добавить иконки для типов дождя
        case .thunderstorm, .drizzle, .rain:
            return Asset.Image.Weather.rain
        case .snow:
            return Asset.Image.Weather.snow
        case .fog:
            return Asset.Image.Weather.fog
        case .unknown:
            return Asset.Image.Weather.clouds
        case .clouds:
            return Asset.Image.Weather.moonCloud
        case .clear:
            return Asset.Image.Weather.moon
        }
    }
}
