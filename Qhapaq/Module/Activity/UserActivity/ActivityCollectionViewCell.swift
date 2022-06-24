//
//  ActivityCollectionViewCell.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 18/07/21.
//

import UIKit
import GenericUtilities

class ActivityCollectionViewCell: UICollectionViewCell, ReuseIdentifier {
    
    let imageViewCustom = UIImageView()
    let titleEventLabel = UILabel()
    let descriptionEventLabel = UILabel()
    
    var data: UserActivityModel! {
        didSet {
            titleEventLabel.text = data.name
            descriptionEventLabel.text = "\(data.distance/1000) km"
        }
    }
    
    let stackView = UIStackView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = .white
        self.contentView.addSubview(stackView)
        imageViewCustom.backgroundColor = .red
        
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.borderWidth = 1
        self.contentView.backgroundColor = .gray
        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        
        stackView.addArrangedSubview(imageViewCustom)
        stackView.spacing = 8
        
        imageViewCustom.translatesAutoresizingMaskIntoConstraints = false
        imageViewCustom.constrainWidth(constant: 100)
        imageViewCustom.constrainHeight(constant: 100)
        imageViewCustom.layer.cornerRadius = 5
        
        let verticalStackView = UIStackView(arrangedSubviews: [titleEventLabel,
                                                               descriptionEventLabel])
        verticalStackView.axis = .vertical
        stackView.addArrangedSubview(verticalStackView)
        stackView.addArrangedSubview(UIView())
    }
    
  
}
