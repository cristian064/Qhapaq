//
//  UserActivityViewController.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 18/07/21.
//

import UIKit
import GenericUtilities
import Combine

class UserActivityViewController: UIViewController, PaginationViewProtocol {
    var viewModel = UserActivityViewModel()
    var refresh: UIRefreshControl = .init(frame: .zero)
    private let searchController = UISearchController(searchResultsController: nil)
    var cancellables = Set<AnyCancellable>()
    
    let collectionView: UICollectionView = {
        //Cell
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
        // Define Group Size
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 32
        
        let compositionLayout = UICollectionViewCompositionalLayout(section: section)
        return UICollectionView(frame: .zero, collectionViewLayout: compositionLayout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.backgroundColor = .white
        setupCollectionView()
        setupBinding()
        callWebServices()
        self.viewModel.setupSubscribeActionFromUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let prefersLargeTitles = self.navigationController?.navigationBar.prefersLargeTitles,
           !prefersLargeTitles {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        viewModel.loadData()
    }
    
    func callWebServices() {
//        viewModel.getUserActivities()
    }
    
    func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    func setupBinding() {
        setupPaginationCombine()
        
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ActivityCollectionViewCell.self, forCellWithReuseIdentifier: ActivityCollectionViewCell.cellIdentifier)
        collectionView.refreshControl = refresh
        refresh.addTarget(self, action: #selector(update), for: .valueChanged)
        collectionView.prefetchDataSource = self
    }
    
    
    
    @objc func update() {
        initialLoadData()
    }
    
    func reloadData() {
        self.collectionView.reloadData()
    }
}

extension UserActivityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityCollectionViewCell
                                                        .cellIdentifier,
                                                            for: indexPath) as? ActivityCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = self.viewModel.elements[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = self.viewModel.elements[indexPath.row]
        let detailUserActivity = DetailUserActivityViewController(userActivity: data)
        self.navigationController?.pushViewController(detailUserActivity, animated: false)
    }
    
}

extension UserActivityViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let indexPathsSorted = indexPaths.sorted(by: {$0.row > $1.row})
        guard let first = indexPathsSorted.first else { return}
        willDisplay(indexPath: first)
    }
}

extension UserActivityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchSubject.value = searchText
    }
}


