//
//  InterestStocksRepository.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/28/24.
//

import Foundation

final class DefaultInterestStocksRepository: InterestStocksRepository {
    private let userDefaultmanager: UserDefaultsManager

    // 실 사용시 Mock 제거
    init(userDefaultmanager: UserDefaultsManager = UserDefaultsManager(userDefaults: MockUserDefaultsStandard())) {
        self.userDefaultmanager = userDefaultmanager
    }

}

extension DefaultInterestStocksRepository {
    func loadInterestStockList() -> [String] {
        userDefaultmanager.load()
    }
}
