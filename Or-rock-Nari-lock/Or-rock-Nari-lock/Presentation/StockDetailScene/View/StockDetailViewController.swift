//
//  StockDetailViewController.swift
//  Or-rock-Nari-lock
//
//  Created by 박동재 on 4/11/24.
//

import UIKit
import DGCharts

final class StockDetailViewController: UIViewController {
    private let chartView = StockChart()

    private let backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupChartView()
    }
}

private extension StockDetailViewController {
    func setupChartView() {
        view.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            chartView.widthAnchor.constraint(equalTo: view.widthAnchor),
            chartView.heightAnchor.constraint(equalToConstant: 300)
        ])

        let chartDataSetOne = ChartDataSetViewModel(
            colorAsset: .third,
            chartDataEntries: makeChartDataset()
        )

        let chartVM = StockChartViewModel(
            chartDataSetViewModels: [chartDataSetOne]
        )
        chartView.viewModel = chartVM
    }

    func makeChartDataset() -> [ChartDataEntry] {

        let dataArray: [(x: Double, y: Double, data: String)] = [
            (1, 2.0, "data1"),
            (2, 3.5, "data2"),
            (3, 1.2, "data3"),
        ]

        var entries: [ChartDataEntry] = dataArray.map { (value) -> ChartDataEntry in
            return ChartDataEntry(x: value.x, y: value.y, data: value.data as AnyObject)
        }

        return entries
    }
}
