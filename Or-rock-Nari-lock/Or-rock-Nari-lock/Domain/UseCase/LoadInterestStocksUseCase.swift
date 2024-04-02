//
//  LoadInterestStocksUseCase.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/28/24.
//

import Foundation

protocol LoadInterestStocksUseCase {
    func execute() -> [String]
}

final class DefaultLoadInterestStocksUseCase: LoadInterestStocksUseCase {
    private let interestStocksRepository: InterestStocksRepository

    init(interestStocksRepository: InterestStocksRepository = DefaultInterestStocksRepository()) {
        self.interestStocksRepository = interestStocksRepository
    }

    func execute() -> [String] {
        interestStocksRepository.loadInterestStockList()
    }
}
