//
//  InterestStocksViewModel.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/28/24.
//

import Foundation
import RxSwift

final class InterestStocksViewModel {
    private let loadInterestStocksUseCase: LoadInterestStocksUseCase
    private let checkTodayPriceUseCase: CheckTodayPriceUseCase

    private var checkStockTasks: [String:Cancellable?] = [:]
    private let mainQueue: DispatchQueueType

    private var stockInformationArray : [StockInformation] = []
    private let stockInformationsSubject = BehaviorSubject<[StockInformation]>(value: [])

    struct Input {
        let viewDidLoadEvent: Observable<Void>
    }

    struct Output {
        let stockInformations: Observable<[StockInformation]>
    }

    init(loadInterestStocksUseCase: LoadInterestStocksUseCase = DefaultLoadInterestStocksUseCase(),
         checkTodayPriceUseCase: CheckTodayPriceUseCase = DefaultCheckTodayPriceUseCase(),
         mainQueue: DispatchQueueType = DispatchQueue.main) {
        self.loadInterestStocksUseCase = loadInterestStocksUseCase
        self.checkTodayPriceUseCase = checkTodayPriceUseCase
        self.mainQueue = mainQueue
    }

    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = createViewModelOutput()
        input.viewDidLoadEvent.subscribe(
            onNext: { [weak self] _ in
                guard let self = self else { return }
                fetchStockInformation(for: self.load(), disposeBag: disposeBag)
            }
        )
        .disposed(by: disposeBag)
        return output
    }
}

private extension InterestStocksViewModel {
    func createViewModelOutput() -> Output {
        Output(stockInformations: stockInformationsSubject.asObservable())
    }

    func load() -> [String] {
        loadInterestStocksUseCase.execute()
    }

    func fetchStockInformation(for names: [String], disposeBag: DisposeBag) {
        Observable.from(names)
            .flatMap { name in
                return self.checkTodayPriceUseCase.execute(stockName: name)
            }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] stockInformation in
                guard let stockInformation else { return }
                self?.stockInformationArray.append(stockInformation)
                guard let stockInformationArray = self?.stockInformationArray else { return }
                self?.stockInformationsSubject.onNext(stockInformationArray)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
}
