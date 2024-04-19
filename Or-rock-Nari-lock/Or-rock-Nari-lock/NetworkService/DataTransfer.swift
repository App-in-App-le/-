//
//  DataTransfer.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/17/24.
//

import Foundation
import RxSwift

protocol DataTransfer {
    typealias CompletionHandler<T> = (Result<T, DataTransferError>) -> Void

    func request<T: Decodable, E: ResponseRequestable>(
        with endPoint: E,
        on queue: DataTransferDispatchQueue,
        completion: @escaping CompletionHandler<T>
    ) -> NetworkCancellable? where E.Response == T
}


final class APIDataTransfer: DataTransfer {
    private let apiProvider: Provider

    init(apiProvider: Provider) {
        self.apiProvider = apiProvider
    }

    func request<T: Decodable, E: ResponseRequestable>(
        with endPoint: E,
        on queue: DataTransferDispatchQueue,
        completion: @escaping CompletionHandler<T>
    ) -> NetworkCancellable? where E.Response == T {
        apiProvider.request(endPoint: endPoint) { result in
            switch result {
            case .success(let data):
                let result: Result<T, DataTransferError> = self.decode(
                    data: data,
                    decoder: endPoint.responseDecoder)
                queue.asyncExecute { completion(result) }
            case .failure(let error):
                let error = self.resolve(networkError: error)
                queue.asyncExecute { completion(.failure(error)) }
            }
        }
    }

    private func decode<T: Decodable>(
        data: Data?,
        decoder: ResponseDecoder
    ) -> Result<T, DataTransferError> {
        do {
            guard let data = data else { return .failure(.noResponse) }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            return .failure(.parsing(error))
        }
    }

    private func resolve(networkError error: NetworkError) -> DataTransferError {
        let resolvedError = error as Error
        return resolvedError is NetworkError
        ? .networkFailure(error)
        : .resolvedNetworkFailure(resolvedError)
    }
}
