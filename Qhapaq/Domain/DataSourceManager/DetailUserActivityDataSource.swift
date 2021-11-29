//
//  DetailUserActivityDataSource.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 7/11/21.
//

import Foundation

protocol DetailUserActivityDataSourceProtocol {
    
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
}
