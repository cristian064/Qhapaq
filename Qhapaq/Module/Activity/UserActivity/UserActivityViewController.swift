//
//  UserActivityViewController.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 18/07/21.
//

import UIKit
import GenericUtilities
import Combine

class UserActivityViewController: UIViewController {

    let viewModel: UserActivityViewModelProtocol  = UserActivityViewModel()
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
//        setupSearchBar()
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
        viewModel.getUserActivities()
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
        self.viewModel.elementsSubject.sink {[weak self] _ in
            self?.collectionView.reloadData()
            self?.refresh.endRefreshing()
        }.store(in: &cancellables)
        
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
    }
    
    let refresh: UIRefreshControl = .init(frame: .zero)
    
    @objc func update() {
        self.viewModel.activity.pageNumber = 1
        self.viewModel.getUserActivities()
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.viewModel.elements.count.decrement() {
            let pageSize = self.viewModel.activity.pageSize
            let pageNumber = (indexPath.row.increment() / pageSize).increment()
            self.viewModel.activity.pageNumber = pageNumber
            self.viewModel.getUserActivities()
        }
    }
    
}

extension UserActivityViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
}

extension UserActivityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchSubject.value = searchText
    }
}
