//
//  ViewController.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 13/07/21.
//

import UIKit
import MapKit
import GenericUtilities
import Combine

class HomeViewController: UIViewController {

    var locationProvider: LocationProvider?
    let mapView = MapView()
    let currentLocationButton = UIButton()
    let viewModel: HomeViewModelProtocol = HomeViewModel()
    private var cancellables = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        setupView()
        setupNavigationController()
        setupBinding()
        
        
    }
    
    func setupBinding() {
        viewModel.locationSubject.sink {[weak self] location in
            self?.mapView.location = location
        }.store(in: &cancellables)
        
        
    }
    
    func setupNavigationController() {
        self.navigationItem.title = "Home"
    }
    
    func setupView() {
        self.view.addSubview(mapView)
        self.view.addSubview(currentLocationButton)
        mapView.anchor(top: self.view.topAnchor,
                       leading: self.view.leadingAnchor,
                       bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                       trailing: self.view.trailingAnchor)
        currentLocationButton.anchor(top: nil,
                                     leading: nil,
                                     bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                                     trailing: self.view.trailingAnchor,
                                     padding: .init(top: 0, left: 0, bottom: 16, right: 16),
                                     size: .init(width: 50, height: 50))

        self.currentLocationButton.backgroundColor = .black
        self.currentLocationButton.layer.cornerRadius = 25
        currentLocationButton.addTarget(self, action: #selector(currentLocationButtonPressed),
                                        for: .touchUpInside)
        currentLocationButton.setImage(UIImage(systemName: "location"), for: .normal)
        currentLocationButton.backgroundColor = .white
        
        currentLocationButton.layer.shadowColor = UIColor.black.cgColor
        currentLocationButton.layer.shadowOffset = .init(width: 1, height: 1)
    }
    
    @objc func currentLocationButtonPressed() {
        viewModel.getLocation()
        
    }
}

