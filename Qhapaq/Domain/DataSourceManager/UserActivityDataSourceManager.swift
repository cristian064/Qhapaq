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

class UserActivityDataSourceManager: UserActivityDataSourceManagerProtocol {
    lazy var repository: ActivityRepositoryProtocol = ActivityRepository()
    
    func getActivities(text: String,
                       completion: @escaping (ResponseAPI<[UserActivityModel]>) -> Void) {
        repository.getAllActivities(text: text, completion: { [weak self] response in
            switch response {
            case .success(let responseData):
                let activityModel = self?.transformActivityToModel(userActivitiesEntity: responseData) ?? []
                completion(.success(activityModel))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func transformActivityToModel(userActivitiesEntity: [ActivityEntity]) -> [UserActivityModel]{
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
