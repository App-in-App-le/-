//
//  Provider.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/16/24.
//

import Foundation

protocol NetworkCancellable {
    func cancel()
}

extension URLSessionTask: NetworkCancellable { }

protocol Provider {
    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void

    func request(endPoint: Requestable, completion: @escaping CompletionHandler) -> NetworkCancellable?
}

final class APIProvider: Provider {
    private let sessionManager: NetworkSessionManager

    init(sessionManager: NetworkSessionManager) {
        self.sessionManager = sessionManager
    }

    func request(endPoint: Requestable, completion: @escaping CompletionHandler) -> NetworkCancellable? {
        do {
            let urlRequest = try endPoint.makeURLRequest()
            return request(request: urlRequest, completion: completion)
        } catch {
            completion(.failure(.urlGeneration))
            return nil
        }
    }

    private func request(request: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable {
        let sessionDataTask = sessionManager.request(request) { data, response, error in
            if let error {
                var networkError: NetworkError
                if let response = response as? HTTPURLResponse {
                    networkError = .error(statusCode: response.statusCode, data: data)
                } else {
                    networkError = self.resolve(error: error)
                }
                completion(.failure(networkError))
            } else {
                completion(.success(data))
            }
        }
        return sessionDataTask
    }

    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet:
            return .notConnected
        case .cancelled:
            return .cancelled
        default:
            return .generic(error)
        }
    }
}
