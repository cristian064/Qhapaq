//
//  LocationProvider.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 13/07/21.
//

import Foundation
import CoreLocation

class LocationProvider: NSObject {
    private let locationManager: CLLocationManager
    
    var currentLocation: CLLocation? {
        return locationManager.location
    }
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        
        locationManager.delegate = self
        locationManager.distanceFilter = 1
        locationManager.requestWhenInUseAuthorization()
        
        
       
    }
    
    
    
}

extension LocationProvider: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            ()
        case .denied:
            ()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
