//
//  ActivityRepository.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 19/07/21.
//

import Foundation

protocol ActivityRepositoryProtocol {
    func getActivities(comletion: @escaping (ResponseApi<[UserActivityEntity]>) -> Void)
}

class ActivityRepository: ActivityRepositoryProtocol {
    
    func getActivities(comletion: @escaping (ResponseApi<[UserActivityEntity]>) -> Void) {
        comletion(.success([.init(distance: 10, name: "ruta 1"),
                            .init(distance: 20, name: "ruta 2")]))
    }
}
