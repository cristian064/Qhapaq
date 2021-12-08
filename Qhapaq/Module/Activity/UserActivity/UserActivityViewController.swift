//
//  UserActivityViewController.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 18/07/21.
//

import UIKit
import GenericUtilities
import Combine

class UserActivityViewController: UICollectionViewController {

    let viewModel: UserActivityViewModelProtocol  = UserActivityViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.backgroundColor = .white
        setupSearchBar()
        setupCollectionView()
        setupBinding()
        callWebServices()
        self.viewModel.setupSubscribeActionFromUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let prefersLargeTitles = self.navigationController?.navigationBar.prefersLargeTitles,
           !prefersLargeTitles{
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
        }.store(in: &cancellables)
    }
    
    
    func setupCollectionView() {
        collectionView.register(ActivityCollectionViewCell.self, forCellWithReuseIdentifier: ActivityCollectionViewCell.cellIdentifier)
    }
    
}

extension UserActivityViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityCollectionViewCell
                                                        .cellIdentifier,
                                                            for: indexPath) as? ActivityCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = self.viewModel.elementsSubject.value[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.elementsSubject.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width - 32, height: 120)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = self.viewModel.elementsSubject.value[indexPath.row]
        let detailUserActivity = DetailUserActivityViewController(userActivity: data)
        self.navigationController?.pushViewController(detailUserActivity, animated: false)
    }
    
    
}

extension UserActivityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchSubject.value = searchText
    }
}
