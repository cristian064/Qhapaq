//
//  ActivityCollectionViewCell.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 18/07/21.
//

import UIKit
import GenericUtilities

class ActivityCollectionViewCell: UITableViewCell, ReuseIdentifier {
    
    let imageViewCustom = UIImageView()
    let titleEventLabel = UILabel()
    let descriptionEventLabel = UILabel()
    let textView = UITextView()
    
    var data: UserActivityModel! {
        didSet {
            titleEventLabel.text = data.name
            descriptionEventLabel.text = "\(data.distance/1000) km"
            textView.text = data.textView
        }
    }
    
    let stackView = UIStackView()
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
                                                               descriptionEventLabel,
                                                               textView])
        textView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textView.backgroundColor = .white
        verticalStackView.axis = .vertical
        stackView.addArrangedSubview(verticalStackView)
        stackView.addArrangedSubview(UIView())
        textView.delegate = self
    }
    
  
}

extension ActivityCollectionViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        data.textView = textView.text
    }
}
