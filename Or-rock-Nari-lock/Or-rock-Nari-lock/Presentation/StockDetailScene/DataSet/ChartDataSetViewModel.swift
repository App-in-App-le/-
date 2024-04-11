//
//  ChartDataSetViewModel.swift
//  Or-rock-Nari-lock
//
//  Created by 박동재 on 4/11/24.
//

import Foundation
import DGCharts

struct ChartDataSetViewModel {
    let colorAsset: ChartDataColor
    let chartDataEntries: [ChartDataEntry]

    init(
        colorAsset: ChartDataColor,
        chartDataEntries: [ChartDataEntry]
    ) {
        self.colorAsset = colorAsset
        self.chartDataEntries = chartDataEntries
    }
}
