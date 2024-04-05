//
//  checkStockRepository.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/29/24.
//

import Foundation
import RxSwift

protocol CheckStockRepository {
    func fetchStockTodayPrices(stockName: String) -> Observable<StockInformation>
}
