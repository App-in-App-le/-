//
//  ChartDataSetViewModel.swift
//  Or-rock-Nari-lock
//
//  Created by 박동재 on 3/5/24.
//

import Foundation

import DGCharts

struct ChartDataSetViewModel {
    let colorAsset: DataColor
    let chartDataEntries: [ChartDataEntry]

    init(
        colorAsset: DataColor,
        chartDataEntries: [ChartDataEntry]
    ) {
        self.colorAsset = colorAsset
        self.chartDataEntries = chartDataEntries
    }
}
