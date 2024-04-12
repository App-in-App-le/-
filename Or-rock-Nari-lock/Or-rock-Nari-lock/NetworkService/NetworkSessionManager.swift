//
//  NetworkSessionManager.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/16/24.
//

import Foundation

protocol NetworkSessionManager {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    func request(_ request: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable
}

final class DefaultNetworkSessionManager: NetworkSessionManager {
    private let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func request(_ request: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable {
        let task = session.dataTask(with: request, completionHandler: completion)
        task.resume()
        return task
    }
}
