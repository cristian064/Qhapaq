//
//  HomeRepository.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 15/07/21.
//

import Foundation
import CoreLocation

protocol HomeRepositoryProtocol: AnyObject {
    func getLocations(completion: @escaping (ResponseApi<CLLocationProtocol>)-> Void)
    func getArtWork(completion: @escaping (ResponseApi<[ArtWorkEntity]>) -> Void)
    func startAdventure(completion: @escaping (ResponseApi<CLLocationDistance>) -> Void)
    func stopAdcenture()
}

class HomeRepository: HomeRepositoryProtocol {
    lazy var locationProvider = LocationProvider()
    func getLocations(completion: @escaping (ResponseApi<CLLocationProtocol>)-> Void) {
        guard let currentLocation = locationProvider.currentLocation else {
            return completion(.failure(.init(code: 1000)))
        }
        completion(.success(currentLocation))
    }
    
    func getArtWork(completion: @escaping (ResponseApi<[ArtWorkEntity]>) -> Void) {
        completion(.success([.init(title: "hey catalina",
                                  locationName: "esteban",
                                  discipline: "edificio",
                                  lat: -12.0847,
                                  longitude: -77.019)]))
    }
    
    func startAdventure(completion: @escaping (ResponseApi<CLLocationDistance>) -> Void) {
        locationProvider.start()
        locationProvider.completionDistance = completion
    }
    
    func getDistance(completion: @escaping (ResponseApi<CLLocationDistance>) -> Void) {
        locationProvider.completionDistance = { distance in
            print(distance)
        }
    }
    
    
    func stopAdcenture() {
        locationProvider.stop()
    }
}
