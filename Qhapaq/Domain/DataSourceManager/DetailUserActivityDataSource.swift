//
//  DetailUserActivityDataSource.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 7/11/21.
//

import Foundation
import GenericUtilities

protocol DetailUserActivityDataSourceProtocol {
    func getAdventureLocations(with name: String,
                               completion: @escaping (ResponseAPI<[CLLocationProtocol]>) -> Void)
}

class DetailUserActivityDataSource: DetailUserActivityDataSourceProtocol {
    lazy var repository: DetailUserActivityRepositoryProtocol = DetailUserActivityRepository()
    
    
    func deleteMovie(userDetailInfo: UserActivityModel,
                     completion: @escaping (ResponseAPI<Void>)-> Void ) {
        
    }
    
    
    func getAdventureLocations(with name: String,
                               completion: @escaping (ResponseAPI<[CLLocationProtocol]>) -> Void) {
        
        repository.getAdventureLocations(with: name) {responseEntity in
            switch responseEntity {
            case .success(let adventureLocations):
                let adventuresModel = adventureLocations.map { locationEntity  -> AdventureLocationModel in
                    return .init(coordinate: .init(latitude: locationEntity.latitude,
                                                   longitude: locationEntity.longitude))
                }
                completion(.success(adventuresModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
