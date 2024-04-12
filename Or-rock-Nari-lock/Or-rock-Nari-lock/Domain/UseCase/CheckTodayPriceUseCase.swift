//
//  CheckTodayPriceUseCase.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/29/24.
//

import Foundation
import RxSwift

protocol CheckTodayPriceUseCase {
    func execute(stockName: String) -> Observable<StockInformation>
}

final class DefaultCheckTodayPriceUseCase: CheckTodayPriceUseCase {
    private let checkStockRepository: CheckStockRepository

    init(checkStockRepository: CheckStockRepository = DefaultCheckStockRepository()) {
        self.checkStockRepository = checkStockRepository
    }

    func execute(stockName: String) -> Observable<StockInformation> {
        checkStockRepository.fetchStockTodayPrices(stockName: stockName)
    }
}
