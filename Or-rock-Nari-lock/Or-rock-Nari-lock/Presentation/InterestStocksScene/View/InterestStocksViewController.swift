//
//  InterestStocksViewController.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/21/24.
//

import UIKit

final class InterestStocksViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout.list(using: config))
        collectionView.register(StockCell.self, forCellWithReuseIdentifier: StockCell.identifier)
        return collectionView
    }()

    private lazy var dataSource =  UICollectionViewDiffableDataSource<UUID, StockInformation>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StockCell.identifier, for: indexPath) as? StockCell else { return UICollectionViewCell() }
        cell.setContent(itemIdentifier)
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        setConstraints()
        collectionView.dataSource = dataSource
        configureDataSource()
    }

    private func setConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func configureDataSource() {
        /// Test
        let testStockInformation = StockInformation(
            name: "애플",
            engName: "Apple",
            price: 9000000000000,
            changePrice: 10000,
            previousDayVarianceSign: .increase
        )
        var snapshot = NSDiffableDataSourceSnapshot<UUID, StockInformation>()
        snapshot.appendSections([UUID()])
        snapshot.appendItems([testStockInformation])
        dataSource.apply(snapshot)
    }

    
}

#Preview {
    InterestStocksViewController()
}
