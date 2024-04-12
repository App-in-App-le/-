//
//  StockChartViewModel.swift
//  Or-rock-Nari-lock
//
//  Created by 박동재 on 4/11/24.
//

import Foundation

protocol StockChartViewModelProtocol {
    var chartDataSetViewModels: [ChartDataSetViewModel] { get set }
}

final class StockChartViewModel: StockChartViewModelProtocol {
    public var chartDataSetViewModels: [ChartDataSetViewModel]

    init(chartDataSetViewModels: [ChartDataSetViewModel]) {
        self.chartDataSetViewModels = chartDataSetViewModels
    }
}
