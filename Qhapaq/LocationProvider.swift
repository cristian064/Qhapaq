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
    var locations : [CLLocation] = []
    private var isStartedLocationUpdate = false
    var completionDistance : ((ResponseApi<CLLocationDistance>) -> Void )?
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestAlwaysAuthorization()
    }
    
    func start() {
        if !isStartedLocationUpdate{
            self.locationManager.startUpdatingLocation()
            isStartedLocationUpdate = true
        }
    }
    
    func stop() {
        isStartedLocationUpdate = false
        locationManager.stopUpdatingLocation()
        distance = 0
    }
    
    func validationLocation(location: CLLocation) {
        if locations.count > 2 {
            if let oldLocation = locations.last {
                locations = [oldLocation, location]
            }
        }else {
            locations.append(location)
        }
        calculateTheDistance()
    }
    
    
    
    var distance : CLLocationDistance = 0{
        didSet{
            completionDistance?(.success(distance))
        }
    }
    
    func calculateTheDistance() {
        if locations.count == 2 {
            let oldLocation = locations[0]
            let newLocation = locations[1]
            
            let fakeDistance = newLocation.distance(from: oldLocation)
            if fakeDistance > 10 {
                distance = distance + fakeDistance
            }
           
        }
        
    }
    
    
}

extension LocationProvider: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            ()
        default:
            ()
        
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        validationLocation(location: location)
    }
    
}
