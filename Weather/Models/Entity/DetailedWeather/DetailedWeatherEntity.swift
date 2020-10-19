//
//  DetailedWeatherEntity.swift
//  Weather
//

import NodeKit

struct DetailedWeatherEntity {
    let daily: [DetailedDailyWeatherEntity]?
    let hourly: [DetailedHourlyWeatherEntity]?
    let minutely: [DetailedMinutelyWeatherEntity]?
}

extension DetailedWeatherEntity: DTODecodable {
    static func from(dto: DetailedWeatherEntry) throws -> DetailedWeatherEntity {
        .init(daily: try .from(dto: dto.daily),
              hourly: try .from(dto: dto.hourly),
              minutely: try .from(dto: dto.minutely))
    }
}

extension DetailedWeatherEntity {
    var sortedHourly: [DetailedHourlyWeatherEntity]? {
        return self.hourly?.sorted(by: { lhs, rhs in
            guard
                let lhsDate = lhs.forecastDate,
                let rhsDate = rhs.forecastDate
            else {
                return false
            }

            return lhsDate.compare(rhsDate) != .orderedDescending
        })
    }

    var sortedMinutely: [DetailedMinutelyWeatherEntity]? {
        return self.minutely?.sorted(by: { lhs, rhs in
            return lhs.forecastDate.compare(rhs.forecastDate) != .orderedDescending
        })
    }

    var sortedDaily: [DetailedDailyWeatherEntity]? {
        return self.daily?.sorted(by: { lhs, rhs in
            return lhs.forecastDate.compare(rhs.forecastDate) != .orderedDescending
        })
    }
}
