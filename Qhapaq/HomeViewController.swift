//
//  ViewController.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 13/07/21.
//

import UIKit
import MapKit
import GenericUtilities

class HomeViewController: UIViewController {

    var locationProvider: LocationProvider?
    let mapView = MKMapView()
    let currentLocationButton = UIButton()
    let viewModel: HomeViewModelProtocol = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        setupView()
        setupTitle()
        setupMap()
        setupBinding()
    }
    
    func setupBinding() {
        
    }
    
    func setupTitle() {
        self.navigationItem.title = "Route"
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
    
    func setupMap() {
        locationProvider = .init()
        
    }
    
    @objc func currentLocationButtonPressed() {
        
        guard let locationUser = locationProvider?.currentLocation else {
            return
        }
        mapView.setRegion(.init(center: locationUser.coordinate,
                                latitudinalMeters: 1000,
                                longitudinalMeters: 1000),
                          animated: true)
        mapView.showsUserLocation = true
        
    }
}

