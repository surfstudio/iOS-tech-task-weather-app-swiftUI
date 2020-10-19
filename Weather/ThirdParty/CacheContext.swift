//
//  CacheContext.swift
//  Weather
//
//  Created by Александр Кравченков on 18.10.2020.
//

import Foundation
import NodeKit

/// Этот контекст позволяет обрабатывать события работы с кешем
final class CacheContext<T>: Context<T> {

    /// model - модель, прочитанная из кеша
    /// isExpired - флаг, указывающий на то, что эта модель протухла
    typealias CacheListener = Closure<(model: T, isExpired: Bool)>

    // MARK: - Properties

    private var onCacheSuccessListener: CacheListener?
    private var onLoadingStartedListener: EmptyClosure?
    private var cacheData: (model: T, isExpired: Bool)?
    private var didLoadindStarted: Bool?

    private var queue: DispatchQueue = .global(qos: .userInitiated)

    // MARK: - Cache

    /// Вызывается в том случае, если удалось прочесть что-то из кеша
    @discardableResult func onCacheSuccess(_ listener: @escaping CacheListener) -> Self {
        if let data = self.cacheData {
            listener(data)
            self.cacheData = nil
        }

        self.onCacheSuccessListener = listener
        return self
    }

    /// Вызывается в том случае, когда началась загрузка данных из сети
    @discardableResult func onLoadingStarted(_ listener: @escaping EmptyClosure) -> Self {
        if self.didLoadindStarted == true {
            listener()
        }

        self.onLoadingStartedListener = listener
        return self
    }

    @discardableResult
    func emitCache(_ data: T, isExpired: Bool) -> Self {
        self.queue.async(flags: .barrier) {
            self.cacheData = (data, isExpired)
            self.onCacheSuccessListener?((data, isExpired))
        }
        return self
    }

    @discardableResult
    func emitStartLoading() -> Self {
        self.queue.async(flags: .barrier) {
            self.didLoadindStarted = true
            self.onLoadingStartedListener?()
        }
        return self
    }

    // MARK: - Context

    @discardableResult
    override func emit(data: T) -> Self {
        self.queue.async(flags: .barrier) {
            super.emit(data: data)
        }
        return self
    }

    @discardableResult
    override func emit(error: Error) -> Self {
        self.queue.async(flags: .barrier) {
            super.emit(error: error)
        }
        return self
    }

    // MARK: - Dispatch

    func dispatch(on queue: DispatchQueue) -> Self {
        self.queue = queue
        return self
    }
}
