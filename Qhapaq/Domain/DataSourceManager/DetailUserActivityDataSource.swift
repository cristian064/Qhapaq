//
//  DetailUserActivityDataSource.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 7/11/21.
//

import Foundation

protocol DetailUserActivityDataSourceProtocol {
    func getAdventureLocations(with name: String,
                               completion: @escaping (ResponseApi<[CLLocationProtocol]>) -> Void)
}

class DetailUserActivityDataSource: DetailUserActivityDataSourceProtocol {
    lazy var repository: DetailUserActivityRepositoryProtocol = DetailUserActivityRepository()
    
    
    func deleteMovie(userDetailInfo: UserActivityModel,
                     completion: @escaping (ResponseApi<Void>)-> Void ) {
        
        
        
//        let entity = ActivityEntity(context: <#T##NSManagedObjectContext#>)
//
//
//        repository.delete(data: ActivityEntity,
//                          completion: completion)
    }
    
    
    func getAdventureLocations(with name: String,
                               completion: @escaping (ResponseApi<[CLLocationProtocol]>) -> Void) {
        
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
