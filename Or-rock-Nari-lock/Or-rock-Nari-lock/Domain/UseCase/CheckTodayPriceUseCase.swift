//
//  CheckTodayPriceUseCase.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/29/24.
//

import Foundation

protocol CheckTodayPriceUseCase {
    func execute(
        stockName: String,
        completion: @escaping (Result<StockInformation, Error>) -> Void
    ) -> Cancellable?
}

final class DefaultCheckTodayPriceUseCase: CheckTodayPriceUseCase {
    private let checkStockRepository: CheckStockRepository

    init(checkStockRepository: CheckStockRepository = DefaultCheckStockRepository()) {
        self.checkStockRepository = checkStockRepository
    }

    func execute(
        stockName: String,
        completion: @escaping (Result<StockInformation, Error>) -> Void)
    -> Cancellable? {
        checkStockRepository.fetchStockTodayPrices(stockNames: stockName) { result in
            completion(result)
        }
    }
}
