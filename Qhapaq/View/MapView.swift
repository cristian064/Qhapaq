//
//  MapView.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 21/07/21.
//

import UIKit
import MapKit
import GenericUtilities

class MapView: UIView {
    
    let mapView = MKMapView()
    
    var location: CLLocationProtocol! {
        didSet{
            setupCurrentLocation()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCurrentLocation() {
        guard let location = location else {return}
        mapView.setRegion(.init(center: location.coordinate,
                                latitudinalMeters: 700,
                                longitudinalMeters: 700), animated: true)
        mapView.showsUserLocation = true
    }
    
    func setupView() {
        self.addSubview(mapView)
        mapView.fillSuperview(padding: .init(top: 8,
                                             left: 8,
                                             bottom: 8,
                                             right: 8))
    }
    
}
