//
//  UserActivityDataSourceManager.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 19/07/21.
//

import Foundation

protocol UserActivityDataSourceManagerProtocol {
    
}

class UserActivityDataSourceManager: UserActivityDataSourceManagerProtocol {
    lazy var repository: ActivityRepositoryProtocol = ActivityRepository()
    
    func getActivities(completion: @escaping (ResponseApi<[UserActivityModel]>) -> Void) {
        repository.getActivities {[weak self] response in
            switch response {
            case .success(let responseData):
                completion(.success(self?.transformActivityToModel(userActivitiesEntity: responseData) ?? []))
            case .failure(let error):
                completion(.failure(error))
            
            }
        }
    }
    
    func transformActivityToModel(userActivitiesEntity: [UserActivityEntity]) -> [UserActivityModel]{
        return userActivitiesEntity.map { userActivitieEntity -> UserActivityModel? in
            guard let distance = userActivitieEntity.distance, let name = userActivitieEntity.name else {
                return nil
            }
            return .init(distance: Double(distance), name: name, date: Date())
        }.compactMap({$0})
        
    }
}
