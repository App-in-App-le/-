//
//  URLSession+.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 4/11/24.
//

import Foundation

extension URLSession {
    static func initMockSession(configuration: URLSessionConfiguration = .ephemeral) -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        return urlSession
    }
}
