//
//  DetailUserActivityDataSource.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 7/11/21.
//

import Foundation
import GenericUtilities
import CoreDataHelp

protocol DetailUserActivityDataSourceProtocol {
    func getAdventureLocations(with name: String,
                               completion: @escaping (ResponseAPI<[CLLocationProtocol]>) -> Void)
    func deleteActivity(userDetailInfo: UserActivityModel,
                        completion: @escaping (ResponseDB<Void>) -> Void)
}

class DetailUserActivityDataSource: DetailUserActivityDataSourceProtocol {
    lazy var repository: DetailUserActivityRepositoryProtocol = DetailUserActivityRepository()
    
    func deleteActivity(userDetailInfo: UserActivityModel,
                        completion: @escaping (ResponseDB<Void>) -> Void) {
        repository.deleteActivity(userDetailInfo: userDetailInfo,
                                  completion: completion)
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
            case .failure:
                completion(.failure)
            }
        }
    }
    
}
