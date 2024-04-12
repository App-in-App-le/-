//
//  StockDayPriceDTO.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 4/11/24.
//

import Foundation

struct StockDayPrice: Codable {
    let outputs: [StockOutput]
    let rtCD, msgCD, msg1: String

    enum CodingKeys: String, CodingKey {
        case outputs = "output"
        case rtCD = "rt_cd"
        case msgCD = "msg_cd"
        case msg1
    }

    // 일자별로 갱신되므로 output array의 첫번째 값만 가져옴
    func toDomain(korName: String, engName: String) -> StockInformation? {
        guard let stockInformationOutput: StockOutput = outputs.first else { return nil }
        guard let price = Int(stockInformationOutput.stckOprc),
              let changePrice = Int(stockInformationOutput.prdyVrss),
              let previousDayVarainceSign = Int(stockInformationOutput.prdyVrssSign)
        else { return nil }
        return StockInformation(
            name: korName,
            engName: engName,
            price: price,
            changePrice: changePrice,
            previousDayVarianceSign: PreviousDayVarianceSign(rawValue: previousDayVarainceSign) ?? .noChange)
    }
}

struct StockOutput: Codable {
    let stckOprc: String
    let prdyVrss: String
    let prdyVrssSign: String

    enum CodingKeys: String, CodingKey {
        case stckOprc = "stck_oprc"
        case prdyVrss = "prdy_vrss"
        case prdyVrssSign = "prdy_vrss_sign"
    }
}
