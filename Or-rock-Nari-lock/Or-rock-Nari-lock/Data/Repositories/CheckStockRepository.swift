//
//  CheckStockRepository.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/29/24.
//

import Foundation

final class DefaultCheckStockRepository: CheckStockRepository {

    private let dataTransferService: DataTransfer
    private let backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)

    init(dataTransferService: DataTransfer = APIDataTransfer(apiProvider: APIProvider(sessionManager: MockNetworkSessionManager(response: nil, data: nil, error: nil)))) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultCheckStockRepository {
    func fetchStockTodayPrices(
        stockNames: String,
        completion: @escaping (Result<StockInformation, Error>) -> Void)
    -> Cancellable? {
        let task = RepositoryTask()
        let endPoint: EndPoint<StockInformationDTO> = EndPoint<StockInformationDTO>(path: "/uapi/domestic-stock/v1/quotations/inquire-price", method: .GET)
        task.networkTask = self.dataTransferService.request(
            with: endPoint,
            on: backgroundQueue,
            completion: { result in
                switch result {
                case .success(let responseDTO):
                    completion(.success(responseDTO.toDomain()))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        return task
    }
}
