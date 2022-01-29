//
//  LocationProvider.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 13/07/21.
//

import Foundation
import CoreLocation
import Combine
import GenericUtilities

class LocationProvider: NSObject {
    private let locationManager: CLLocationManager
    
    var currentLocation: CLLocation? {
        return locationManager.location
    }
    private var distanceLocations: [CLLocation] = []
    private var isStartedLocationUpdate = false
    private var locations: [CLLocation] = [] {
        didSet {
            locationsSubject.value = locations
        }
    }
    var completionDistance: ((ResponseAPI<CLLocationDistance>) -> Void )?
    var locationsSubject = CurrentValueSubject<[CLLocationProtocol], Never>([])
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        locationManager.requestAlwaysAuthorization()
    }
    
    func start() {
        if !isStartedLocationUpdate{
            self.locationManager.startUpdatingLocation()
            isStartedLocationUpdate = true
            startTrackingAdventure()
            distance = 0
            locations = []
        }
    }
    
    func startTrackingAdventure() {
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.activityType = .automotiveNavigation
    }
    func stop() {
        if isStartedLocationUpdate {
            isStartedLocationUpdate = false
            locationManager.stopUpdatingLocation()
            locationManager.allowsBackgroundLocationUpdates = false
            locationManager.stopMonitoringSignificantLocationChanges()
        
        }
    }
    
    func validationLocation(location: CLLocation) {
        if distanceLocations.count > 2 {
            if let oldLocation = distanceLocations.last {
                distanceLocations = [oldLocation, location]
            }
        } else {
            distanceLocations.append(location)
        }
        calculateTheDistance()
    }
    var distance: CLLocationDistance = 0 {
        didSet {
            completionDistance?(.success(distance))
        }
    }
    
    func calculateTheDistance() {
        if distanceLocations.count == 2 {
            let oldLocation = distanceLocations[0]
            let newLocation = distanceLocations[1]
            
            let fakeDistance = newLocation.distance(from: oldLocation)
            if fakeDistance > 10 {
                distance += fakeDistance
            }
        }
    }
    
    func validateLocationsUpate(with location: CLLocation) {
        guard let lastLocation = locations.last else {
            locations.append(location)
            return
        }
        if lastLocation.distance(from: location) > 10 {
            locations.append(location)
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
        validateLocationsUpate(with: location)
    }
}
