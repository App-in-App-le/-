//
//  MockCheckStockRepository.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 4/11/24.
//

import Foundation
import RxSwift

final class MockCheckStockRepository {
    private let dataTransferService: DataTransfer
    private let backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)
    private var currentIndex = -1
    private var mockDatas: [Data] = []

    init(dataTransferService: DataTransfer = APIDataTransfer(apiProvider: APIProvider(sessionManager: DefaultNetworkSessionManager(session: .initMockSession()))) ) {
        self.dataTransferService = dataTransferService
    }
}

extension MockCheckStockRepository: CheckStockRepository {
    func fetchStockTodayPrices(stockName: String) -> Observable<StockInformation?> {
        var mockName: String
        switch stockName {
        case "SK하이닉스":
            mockName = "MockStock1"
        case "삼성":
            mockName = "MockStock2"
        case "네이버":
            mockName = "MockStock3"
        default:
            mockName = "MockStock1"
        }

        guard let mockFileLocation = Bundle.main.url(forResource: mockName, withExtension: "json"),
              let mockData = try? Data(contentsOf: mockFileLocation) else {
            return Observable.just(nil)
        }
        mockDatas.append(mockData)
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            self.currentIndex += 1
            let currentIndex = min(self.currentIndex, self.mockDatas.indices.last ?? 0)
            return (response, self.mockDatas[currentIndex], nil)
        }

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
