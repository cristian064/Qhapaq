//
//  UserActivityDataSourceManager.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 19/07/21.
//

import Foundation
import GenericUtilities

protocol UserActivityDataSourceManagerProtocol {
    
}

protocol PaginationProtocol {
    var pageNumber: Int {get set}
    var pageSize: Int {get set}
}

struct ActivityRequest: PaginationProtocol {
    let text: String
    var pageNumber: Int
    var pageSize: Int
}

class UserActivityDataSourceManager: UserActivityDataSourceManagerProtocol {
    lazy var repository: ActivityRepositoryProtocol = ActivityRepository()
    
    func getActivities(request: ActivityRequest,
                       completion: @escaping (ResponseAPI<UserActivityPaginated>) -> Void) {
        if let data = MockData.shared.getData(with: request){
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                completion(.success(data))
            })
            
        } else {
            completion(.failure(.init(code: 10)))
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
//    private let paginationData: UserActivityPaginated
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
            return .init(pageNumber: request.pageNumber, pageSize: request.pageSize, activities: sliced)
        }
        return nil
    }
    
}

