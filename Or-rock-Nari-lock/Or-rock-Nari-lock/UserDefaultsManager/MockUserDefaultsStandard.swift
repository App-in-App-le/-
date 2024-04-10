//
//  MockUserDefaultsStandard.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/29/24.
//

import Foundation

final class MockUserDefaultsStandard: UserDefaultsProtocol {
    var stocksList: [String] = ["카카오", "삼성", "네이버"]

    func set(_ value: Any?, forKey defaultName: String) {
        guard let stock: String = value as? String else { return }
        stocksList.append(stock)
    }
    
    func array(forKey: String) -> [Any]? {
        stocksList
    }
}
