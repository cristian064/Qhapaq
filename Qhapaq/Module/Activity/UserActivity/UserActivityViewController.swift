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
    
//    let collectionView: UICollectionView = {
//        //Cell
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(120))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//        // Define Group Size
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(120))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//
//        //section
//        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = 32
//
//        let compositionLayout = UICollectionViewCompositionalLayout(section: section)
//        return UICollectionView(frame: .zero, collectionViewLayout: compositionLayout)
//    }()
//
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.backgroundColor = .white
        setupCollectionView()
        setupBinding()
        callWebServices()
        self.viewModel.setupSubscribeActionFromUI()
        viewModel.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let prefersLargeTitles = self.navigationController?.navigationBar.prefersLargeTitles,
           !prefersLargeTitles {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
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
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.register(ActivityCollectionViewCell.self, forCellWithReuseIdentifier: ActivityCollectionViewCell.ce)
        tableView.register(ActivityCollectionViewCell.self, forCellReuseIdentifier: ActivityCollectionViewCell.reuseIdentifier)
        tableView.refreshControl = refresh
        refresh.addTarget(self, action: #selector(update), for: .valueChanged)
//        collectionView.prefetchDataSource = self
        tableView.prefetchDataSource = self
    }
    
    
    
    @objc func update() {
        initialLoadData()
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
}

//extension UserActivityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityCollectionViewCell
//                                                        .cellIdentifier,
//                                                            for: indexPath) as? ActivityCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//        cell.data = self.viewModel.elements[indexPath.row]
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.viewModel.elements.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let data = self.viewModel.elements[indexPath.row]
//        let detailUserActivity = DetailUserActivityViewController(userActivity: data)
//        self.navigationController?.pushViewController(detailUserActivity, animated: false)
//    }
//
//}

extension UserActivityViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivityCollectionViewCell.reuseIdentifier, for: indexPath) as? ActivityCollectionViewCell else {
            return UITableViewCell()
        }
        cell.data = self.viewModel.elements[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.elements.count
    }
    
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let indexPathsSorted = indexPaths.sorted(by: {$0.row > $1.row})
        guard let first = indexPathsSorted.first else { return}
        willDisplay(indexPath: first)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
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


