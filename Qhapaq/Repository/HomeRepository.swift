//
//  HomeRepository.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 15/07/21.
//

import Foundation
import CoreLocation
import Combine
import CoreData
import GenericUtilities
import CoreDataHelp

protocol HomeRepositoryProtocol: StorageAPI {
    func getLocation(completion: @escaping (ResponseAPI<CLLocationProtocol>) -> Void)
    func getArtWork(completion: @escaping (ResponseAPI<[ArtWorkEntity]>) -> Void)
    func startAdventure(completion: @escaping (ResponseAPI<CLLocationDistance>) -> Void)
    func getLocations(completion: @escaping (ResponseAPI<[CLLocationProtocol]>) -> Void)
    func stopAdcenture()
    func save(distance: Double,
              name: String,
              locations: [CLLocationProtocol],
              completion: @escaping (ResponseAPI<Void>) -> Void)
}

class HomeRepository: HomeRepositoryProtocol {
    var persistentContainer: NSPersistentContainer = StorageProvider.shared.persistentContainer
    
    private var cancellables = Set<AnyCancellable>()
    lazy var locationProvider = LocationProvider()
    func getLocation(completion: @escaping (ResponseAPI<CLLocationProtocol>) -> Void) {
        guard let currentLocation = locationProvider.currentLocation else {
            return completion(.failure(.init(code: 1000)))
        }
        completion(.success(currentLocation))
    }
    
    func getArtWork(completion: @escaping (ResponseAPI<[ArtWorkEntity]>) -> Void) {
        completion(.success([.init(title: "hey catalina",
                                  locationName: "esteban",
                                  discipline: "edificio",
                                  lat: -12.0847,
                                  longitude: -77.019)]))
    }
    
    func startAdventure(completion: @escaping (ResponseAPI<CLLocationDistance>) -> Void) {
        locationProvider.start()
        locationProvider.completionDistance = completion
    }
    
    func getDistance(completion: @escaping (ResponseAPI<CLLocationDistance>) -> Void) {
        locationProvider.completionDistance = { [weak self] distance in
            print(distance)
        }
    }
    
    func stopAdcenture() {
        locationProvider.stop()
    }
    
    func getLocations(completion: @escaping (ResponseAPI<[CLLocationProtocol]>) -> Void) {
        locationProvider.locationsSubject.sink { locations in
            completion(.success(locations))
        }.store(in: &cancellables)
    }
    
    func save(distance: Double,
              name: String,
              locations: [CLLocationProtocol],
              completion: @escaping (ResponseAPI<Void>) -> Void) {
        let activity = ActivityEntity(context: StorageProvider.shared.persistentContainer.viewContext)
        activity.distance = distance
        activity.date = Date()
        activity.name = name
        
        locations.forEach { location in
            let locationEntity = ActivityLocationEntity(context: StorageProvider.shared.persistentContainer.viewContext)
            locationEntity.latitude = location.coordinate.latitude
            locationEntity.longitude = location.coordinate.longitude
            activity.addToLocations(locationEntity)
        }
        self.saveDB(completion: completion)
    }
}
