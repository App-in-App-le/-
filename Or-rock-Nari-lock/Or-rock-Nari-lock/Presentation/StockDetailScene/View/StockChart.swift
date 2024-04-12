//
//  StockChart.swift
//  Or-rock-Nari-lock
//
//  Created by 박동재 on 4/11/24.
//

import UIKit
import DGCharts

final class StockChart: UIView {

    private let chart = LineChartView()
    private var dataSetFactory: ChartDataSetFactory!

    var viewModel: StockChartViewModelProtocol? {
        didSet {
            updateChartDatasets()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        dataSetFactory = ChartDataSetFactory()
        setupChartView()
    }

    required init?(coder: NSCoder) {
        fatalError("invaild Error")
    }
}

private extension StockChart {

    private func setupChartView() {
        addSubview(chart)
        chart.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chart.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            chart.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            chart.topAnchor.constraint(equalTo: self.topAnchor),
            chart.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        chart.isUserInteractionEnabled = false

        chart.xAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        chart.rightAxis.drawGridLinesEnabled = false
        chart.drawGridBackgroundEnabled = false
        chart.xAxis.drawLabelsEnabled = false
        chart.leftAxis.drawLabelsEnabled = false
        chart.rightAxis.drawLabelsEnabled = false
        chart.legend.enabled = false
        chart.pinchZoomEnabled = false
        chart.doubleTapToZoomEnabled = false
        chart.xAxis.enabled = false
        chart.leftAxis.enabled = false
        chart.rightAxis.enabled = false
        chart.drawBordersEnabled = false
        chart.minOffset = 0
    }

    private func updateChartDatasets() {
        guard let viewModel = viewModel else { return }
        let datasets = viewModel.chartDataSetViewModels.map {
            dataSetFactory.makeChartDataset(
                colorAsset: $0.colorAsset,
                entries: $0.chartDataEntries
            )
        }
        let chartData = LineChartData(dataSets: datasets)
        chart.data = chartData
    }
}
