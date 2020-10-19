//
//  CachedModel.swift
//  Weather
//
//  Created by Александр Кравченков on 17.10.2020.
//

import Foundation

/// Обертка для модели, которая позволяет хранить вместе инофрмацию о том,
/// "протухла" и конкретная модель данных в кеше
/// И саму модель
struct CachedModel<T> {
    let isExpired: Bool
    let value: T
}
