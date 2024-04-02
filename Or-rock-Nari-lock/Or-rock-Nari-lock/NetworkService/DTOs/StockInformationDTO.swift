//
//  StockInformationDTO.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/29/24.
//

import Foundation

struct StockInformationDTO: Decodable {
    let name: String
    let engName: String
    let price: Int
    let changePrice: Int
    let previousDVS: Int

    func toDomain() -> StockInformation {
        StockInformation(
            name: name,
            engName: engName,
            price: price,
            changePrice: changePrice,
            previousDayVarianceSign: PreviousDayVarianceSign(rawValue: previousDVS) ?? .increase)
    }
}
