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
    let startAdventureButton = UIButton()
    let saveAdventure = UIButton()
    let viewModel: HomeViewModelProtocol = HomeViewModel()
    let distanceAdventureLabel = UILabel()
    lazy var containerOptionStackView = UIStackView(arrangedSubviews: [startAdventureButton,
                                                                       saveAdventure,
                                                                       currentLocationButton])
    private var cancellables = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        setupView()
        setupNavigationController()
        setupBinding()
        
        viewModel.getArtWork()
        viewModel.getLocation()
        viewModel.stopLocationUpdate()
    }
    
    func setupBinding() {
        viewModel.locationSubject.sink {[weak self] location in
            self?.mapView.location = location
        }.store(in: &cancellables)
        
        viewModel.distanceOfAdventureSubject.sink {[weak self] distance in
            self?.distanceAdventureLabel.text = "\(String(format: "%.3f", distance/1000)) Km"
        }.store(in: &cancellables)
        
        viewModel.locationsSubject.sink {[weak self] locations in
            self?.mapView.addOverlay(with: locations)
        }.store(in: &cancellables)
    }
    
    func setupNavigationController() {
        self.navigationItem.title = "Home"
    }
    
    func setupView() {
        self.view.addSubview(mapView)
        self.view.addSubview(containerOptionStackView)
        self.view.addSubview(distanceAdventureLabel)
        
        
        
        mapView.anchor(top: self.view.topAnchor,
                       leading: self.view.leadingAnchor,
                       bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                       trailing: self.view.trailingAnchor)
        
        distanceAdventureLabel.anchor(top: self.view.topAnchor,
                                      leading: self.view.leadingAnchor,
                                      bottom: nil,
                                      trailing: self.view.trailingAnchor)
        
        distanceAdventureLabel.backgroundColor = .gray
        distanceAdventureLabel.textAlignment = .center
        containerOptionStackView.anchor(top: nil,
                                     leading: nil,
                                     bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                                     trailing: self.view.trailingAnchor,
                                     padding: .init(top: 0, left: 0, bottom: 16, right: 16))

        
        
        
        containerOptionStackView.spacing = 10
        currentLocationButton.constrainWidth(constant: 50)
        currentLocationButton.constrainHeight(constant: 50)
        self.currentLocationButton.backgroundColor = .black
        self.currentLocationButton.layer.cornerRadius = 25
        self.startAdventureButton.layer.cornerRadius = 25
        
        startAdventureButton.setTitle("Start adventure", for: .normal)
        startAdventureButton.backgroundColor = .green
//        startAdventureButton.constrainWidth(constant: 50)
        
        saveAdventure.setTitle("Save adventure", for: .normal)
        saveAdventure.backgroundColor = .gray
//        saveAdventure.constrainWidth(constant: 50)
        
        
        startAdventureButton.addTarget(self, action: #selector(startAdventureButtonAction),
                                       for: .touchUpInside)
        
        saveAdventure.addTarget(self, action: #selector(saveAdventureAction),
                                for: .touchUpInside)
        
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
    
    @objc func startAdventureButtonAction() {
        viewModel.startAdventure()
        viewModel.getLocations()
    }
    
    @objc func saveAdventureAction() {
        viewModel.saveAdventure()
    }
    
}

