//
//  InterestStocksViewController.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/21/24.
//

import UIKit
import RxSwift

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

    private let disposeBag: DisposeBag = DisposeBag()
    // TODO: Coordinator에서 생성
    private var viewModel: InterestStocksViewModel = InterestStocksViewModel()
    private let viewLoad = PublishSubject<Void>()

    private let searchStocksViewController = SearchStocksViewController()
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: searchStocksViewController)
        searchController.searchBar.delegate = self
        return searchController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewLoad.onNext(())
    }

    private func setupViews() {
        setConstraints()
        collectionView.dataSource = dataSource
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "관심 종목 리스트"
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

    private func bindViewModel() {
        let input = InterestStocksViewModel.Input(viewDidLoadEvent: viewLoad.asObservable())
        let output = viewModel.transform(from: input, disposeBag: disposeBag)

        output.stockInformations
            .subscribe(onNext: { [weak self] stockInformationArray in
                guard let self = self else { return }

                var snapshot = NSDiffableDataSourceSnapshot<UUID, StockInformation>()
                snapshot.appendSections([UUID()])
                snapshot.appendItems(stockInformationArray)
                self.dataSource.apply(snapshot, animatingDifferences: true)
            })
            .disposed(by: disposeBag)
    }

}

extension InterestStocksViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let resultViewController = self.searchController.searchResultsController as? SearchStocksViewController,
        let text = searchBar.text
        else { return }
        resultViewController.searchStock(text)
    }
}
//
//#Preview {
//    InterestStocksViewController()
//}
