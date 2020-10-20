//
//  CachedServiceContants.swift
//  Weather
//
//  Created by Александр Кравченков on 17.10.2020.
//

import Foundation

enum CachedServiceContants {
    /// Время "жизни" для кеша
    /// В случае, если кеш лежит в базе дольше указанного времени
    /// То считается, что данные уже устрели
    static let timeToLife = TimeInterval(30 * 60)
}
