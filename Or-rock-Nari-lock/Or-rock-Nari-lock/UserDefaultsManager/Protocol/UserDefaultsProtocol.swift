//
//  UserDefaultsProtocol.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/28/24.
//

import Foundation

protocol UserDefaultsProtocol {
    func set(_ value: Any?, forKey defaultName: String)
    func array(forKey: String) -> [Any]?
}
