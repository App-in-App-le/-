//
//  checkStockRepository.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/29/24.
//

import Foundation

protocol CheckStockRepository {
    func fetchStockTodayPrices(
        stockNames: String,
        completion: @escaping (Result<StockInformation, Error>) -> Void
    ) -> Cancellable?
}
