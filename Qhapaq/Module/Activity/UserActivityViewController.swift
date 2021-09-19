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
    let addEventButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addEventButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.backgroundColor = .white
        setupSearchBar()
        setupCollectionView()
        setupBinding()
        callWebServices()
        setupView()
        self.viewModel.setupSubscribeActionFromUI()
    }
    
    
    
    func setupView() {
        self.view.addSubview(addEventButton)
        addEventButton.backgroundColor = .black
        
        addEventButton.anchor(top: nil,
                                     leading: nil,
                                     bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                                     trailing: self.view.trailingAnchor,
                                     padding: .init(top: 0, left: 0, bottom: 16, right: 16),
                                     size: .init(width: 50, height: 50))
        addEventButton.layer.cornerRadius = 25
    }
    
    func callWebServices() {
        viewModel.getUserActivities()
    }
    
    func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    func setupBinding() {
        
    }
    
    
    func setupCollectionView() {
        collectionView.register(ActivityCollectionViewCell.self, forCellWithReuseIdentifier: ActivityCollectionViewCell.cellIdentifier)
    }
    
    
    @objc func addEventButtonPressed(_ button : UIButton){
        print("add event")
    }
}

extension UserActivityViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityCollectionViewCell
                                                        .cellIdentifier,
                                                      for: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.elementsSubject.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width - 32, height: 120)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    
}

extension UserActivityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchSubject.value = searchText
    }
}
