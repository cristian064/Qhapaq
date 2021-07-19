//
//  ActivityCollectionViewCell.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 18/07/21.
//

import UIKit

class ActivityCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        self.backgroundColor = .red
    }
}
