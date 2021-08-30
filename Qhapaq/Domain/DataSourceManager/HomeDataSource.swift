//
//  HomeDataSource.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 24/07/21.
//

import Foundation

protocol HomeDataSourceProtocol {
    var repository: HomeRepositoryProtocol {get}
    func getLocations(completion: @escaping (ResponseApi<CLLocationProtocol>)-> Void)
    func getArtWork(completion: @escaping (ResponseApi<[ArtWorkModel]>) -> Void)
}

class HomeDataSource: HomeDataSourceProtocol {

    lazy var repository: HomeRepositoryProtocol = HomeRepository()
    
    func getLocations(completion: @escaping (ResponseApi<CLLocationProtocol>) -> Void) {
        repository.getLocations(completion: completion)
    }
    
    func getArtWork(completion: @escaping (ResponseApi<[ArtWorkModel]>) -> Void) {
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
    
    
}
