//
//  CheckStockRepository.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/29/24.
//

import Foundation
import RxSwift

final class DefaultCheckStockRepository: CheckStockRepository {

    private let dataTransferService: DataTransfer
    private let backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)

    init(dataTransferService: DataTransfer = APIDataTransfer(apiProvider: APIProvider(sessionManager: MockNetworkSessionManager(response: nil, data: nil, error: nil)))) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultCheckStockRepository {
    func fetchStockTodayPrices(stockName: String) -> Observable<StockInformation?> {
        return Observable.create { observer in
            let task = RepositoryTask()
            let endPoint: EndPoint<StockDayPriceDTO> = EndPoint<StockDayPriceDTO>(path: "/uapi/domestic-stock/v1/quotations/inquire-price", method: .GET)
            task.networkTask = self.dataTransferService.request(
                with: endPoint,
                on: self.backgroundQueue,
                completion: { result in
                    switch result {
                    case .success(let responseDTO):
                        observer.onNext(responseDTO.toDomain(korName: stockName, engName: stockName))
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                })
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
