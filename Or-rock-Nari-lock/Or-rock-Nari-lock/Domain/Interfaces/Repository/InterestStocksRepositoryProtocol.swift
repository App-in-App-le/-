//
//  InterestStocksRepository.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/28/24.
//

import Foundation

protocol InterestStocksRepository {
    func loadInterestStockList() -> [String]
}
