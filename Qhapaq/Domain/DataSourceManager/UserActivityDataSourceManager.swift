//
//  UserActivityDataSourceManager.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 19/07/21.
//

import Foundation
import GenericUtilities
import CoreDataHelp

protocol UserActivityDataSourceManagerProtocol {
    
}

class UserActivityDataSourceManager: UserActivityDataSourceManagerProtocol {
    lazy var repository: ActivityRepositoryProtocol = ActivityRepository()
    
    func getActivities(request: ActivityRequest,
                       completion: @escaping (ResponseDB<UserActivityPaginated>) -> Void) {
        if let data = MockData.shared.getData(with: request){
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                completion(.success(data))
//            })
            
        } else {
            completion(.failure(.cannotLoad))
        }
        
        
        
    }
    
    func transformActivityToModel(userActivitiesEntity: [ActivityEntity]) -> [UserActivityModel] {
        return userActivitiesEntity.map { userActivitieEntity -> UserActivityModel? in
            guard let date = userActivitieEntity.date,
                    let name = userActivitieEntity.name else {
                    return nil
            }
            return .init(distance: userActivitieEntity.distance,
                         name: name,
                         date: date)
        }.compactMap({$0})
        
    }
}

class MockData {
    static let shared = MockData()
    private var data: [UserActivityModel] = []
    private init() {
        for index in 1...100 {
            data.append(.init(distance: Double(index), name: "\(index)", date: Date()))
        }
    }
    
    func getData(with request: ActivityRequest) -> UserActivityPaginated? {
        if request.pageNumber <= 10 {
            let initial = request.pageSize * (request.pageNumber - 1)
            let final = request.pageSize * (request.pageNumber)
            let sliced = Array(data[initial..<final])
            return .init(pageNumber: request.pageNumber, pageSize: request.pageSize, pageTotal: 10, data: sliced)
        }
        return nil
    }
    
}

