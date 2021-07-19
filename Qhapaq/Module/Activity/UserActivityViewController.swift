//
//  UserActivityViewController.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 18/07/21.
//

import UIKit
import GenericUtilities

class UserActivityViewController: UICollectionViewController {

    let viewModel = UserActivityViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.backgroundColor = .white
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.register(ActivityCollectionViewCell.self, forCellWithReuseIdentifier: ActivityCollectionViewCell.cellIdentifier)
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
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width - 32, height: 50)
    }
}
