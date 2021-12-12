//
//  HomeDataSource.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 24/07/21.
//

import Foundation
import CoreLocation
import GenericUtilities

protocol HomeDataSourceProtocol {
    var repository: HomeRepositoryProtocol {get}
    func getLocation(completion: @escaping (ResponseAPI<CLLocationProtocol>)-> Void)
    func getArtWork(completion: @escaping (ResponseAPI<[ArtWorkModel]>) -> Void)
    func startAdventure(completion: @escaping (ResponseAPI<CLLocationDistance>) -> Void)
    func getLocations(completion: @escaping (ResponseAPI<[CLLocationProtocol]>) -> Void)
    func saveAdventure(name: String,
                       distance: Double,
                       locations: [CLLocationProtocol],
                       completion: @escaping (ResponseAPI<Void>) -> Void)
    func stopAdventure()
}

class HomeDataSource: HomeDataSourceProtocol {

    lazy var repository: HomeRepositoryProtocol = HomeRepository()
    
    func getLocation(completion: @escaping (ResponseAPI<CLLocationProtocol>) -> Void) {
        repository.getLocation(completion: completion)
    }
    
    func getArtWork(completion: @escaping (ResponseAPI<[ArtWorkModel]>) -> Void) {
        repository.getArtWork {response in
            switch response {
            case .success(let entityData):
                let artWorkModel = entityData.map { artWorkModel -> ArtWorkModel? in
                    guard let longitude = artWorkModel.longitude,
                          let latitude = artWorkModel.lat,
                          let locationName = artWorkModel.locationName else {
                        return nil
                    }
                    return .init(title: artWorkModel.title ?? "",
                                 locationName: locationName,
                                 discipline: artWorkModel.discipline ?? "",
                                 lat: latitude,
                                 longitude: longitude)
                }.compactMap({$0})
                completion(.success(artWorkModel))

            case .failure(let error):
                completion(.failure(.init(code: 400)))
            }
        }
    }
    
    func startAdventure(completion: @escaping (ResponseAPI<CLLocationDistance>) -> Void) {
        repository.startAdventure(completion: completion)
    }
    
    func stopAdventure() {
        self.repository.stopAdcenture()
    }
    
    func getLocations(completion: @escaping (ResponseAPI<[CLLocationProtocol]>) -> Void) {
        self.repository.getLocations(completion: completion)
    }
    
    func saveAdventure(name: String,
                       distance: Double,
                       locations: [CLLocationProtocol],
                       completion: @escaping (ResponseAPI<Void>) -> Void) {
        self.repository.save(distance: distance,
                             name: name,
                             locations: locations,
                             completion: completion)
    }
}
