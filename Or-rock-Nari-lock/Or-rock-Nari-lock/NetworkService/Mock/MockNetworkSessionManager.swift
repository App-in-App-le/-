//
//  MockNetworkSessionManager.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/29/24.
//

import Foundation

final class MockNetworkSessionManager: NetworkSessionManager {
    var response: HTTPURLResponse?
    let data: Data?
    let error: Error?

    init(response: HTTPURLResponse?, data: Data?, error: Error?) {
        self.response = response
        self.data = data
        self.error = error
    }

    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) -> NetworkCancellable {
        response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        if let url = Bundle.main.url(forResource: "MockStock", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                completion(jsonData, response, error)
            } catch {
                completion(nil, response, error)
            }
        } else {
            completion(nil, response, NSError(domain: "MockNetworkSessionManager", code: 404))
        }
        return MockURLSessionDataTask()
    }
}

final class MockURLSessionDataTask: NetworkCancellable {
    func cancel() {
        print("DataTask cancelled")
    }
}
