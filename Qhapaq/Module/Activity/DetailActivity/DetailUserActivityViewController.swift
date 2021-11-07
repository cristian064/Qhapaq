//
//  DetailUserActivityViewController.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 7/11/21.
//

import UIKit

class DetailUserActivityViewController: UIViewController {

    
    let viewModel: DetailUserActivityViewModelProtocol
    let adventureImageView =  UIImageView()
    let nameAdventure = UILabel()
    let detailAdventure = UILabel()
    lazy var stackView : UIStackView = .init(arrangedSubviews: [nameAdventure,
                                                                detailAdventure,
                                                                adventureImageView])
    init(userActivity: UserActivityModel) {
        self.viewModel = DetailUserActivityViewModel(userActivity: userActivity)
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupNavigationController()
        setupViews()
        setupConstraints()
    }
    
    func setupConstraints() {
        self.view.addSubview(stackView)
        
        stackView.fillSuperview()
    }
    
    func setupViews() {
        stackView.axis = .vertical
        stackView.spacing = 16
        
        adventureImageView.backgroundColor = .red
        self.nameAdventure.textAlignment = .center
        self.detailAdventure.textAlignment = .center
        self.nameAdventure.text = self.viewModel.userActivity.name
        self.detailAdventure.text = "\(self.viewModel.userActivity.distance) Km"
    }
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = self.viewModel.adventureTitle
        self.navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .trash,
                                                       target:self,
                                                       action: #selector(deleteActivityButtonPressed))
    }
    
    @objc func deleteActivityButtonPressed() {
        print("hola")
    }
}
