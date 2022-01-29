//
//  DetailUserActivityViewController.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 7/11/21.
//

import UIKit
import CoreData
import Combine
import MapKit

class DetailUserActivityViewController: UIViewController {

    let viewModel: DetailUserActivityViewModelProtocol
    let adventureMapView =  MapView()
    let nameAdventure = UILabel()
    let detailAdventure = UILabel()
    var cancellables = Set<AnyCancellable>()
    lazy var stackView: UIStackView = .init(arrangedSubviews: [nameAdventure,
                                                                detailAdventure,
                                                                adventureMapView])
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
        
        setupBinding()
        setupNavigationController()
        setupViews()
        setupConstraints()
        self.viewModel.getAdventureLocations()
    }
    
    func setupBinding() {
        self.viewModel.locationsOfAdventureSubject.sink {[weak self] adventures in
            self?.adventureMapView.addOverlay(with: adventures)
        }.store(in: &cancellables)
    }
    
    func setupConstraints() {
        self.view.addSubview(stackView)
        
        stackView.fillSuperview()
    }
    
    func setupViews() {
        stackView.axis = .vertical
        stackView.spacing = 16
        
        self.nameAdventure.textAlignment = .center
        self.detailAdventure.textAlignment = .center
        self.nameAdventure.text = self.viewModel.userActivity.name
        self.detailAdventure.text = "\(self.viewModel.userActivity.distance) Km"
    }
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = self.viewModel.adventureTitle
        self.navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .trash,
                                                       target: self,
                                                       action: #selector(deleteActivityButtonPressed))
    }
    
    @objc func deleteActivityButtonPressed() {
        print("hola")
    }
}
