//
//  StockInformation.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/24/24.
//

import Foundation

enum PreviousDayVarianceSign: Int {
    case upperLimit = 1
    case increase
    case noChange
    case lowerLimit
    case decrease
}

struct StockInformation: Hashable {
    let name: String
    let engName: String
    let price: Int
    let changePrice: Int
    let previousDayVarianceSign: PreviousDayVarianceSign
}
