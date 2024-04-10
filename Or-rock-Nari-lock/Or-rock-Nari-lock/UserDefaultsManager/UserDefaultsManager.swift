//
//  UserDefaultsManager.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/28/24.
//

import Foundation

final class UserDefaultsManager {
    private let userDefaults: UserDefaultsProtocol
    let userDefaultsKey: String = "stocks"

    init(userDefaults: UserDefaultsProtocol = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    func save(stock: String) {
        var stockList: [String] = userDefaults.array(forKey: userDefaultsKey) as? [String] ?? []
        stockList.append(stock)
        userDefaults.set(stockList, forKey: userDefaultsKey)
    }

    func load() -> [String] {
        userDefaults.array(forKey: userDefaultsKey) as? [String] ?? []
    }
}

extension UserDefaults: UserDefaultsProtocol {

}
