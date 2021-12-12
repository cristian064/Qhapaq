//
//  ActivityRepository.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 19/07/21.
//

import Foundation
import CoreData
import GenericUtilities

protocol ActivityRepositoryProtocol: DBRepository {
    func getActivities(comletion: @escaping (ResponseAPI<[UserActivityEntity]>) -> Void)
}

class ActivityRepository: ActivityRepositoryProtocol {
    var persistentContainer: NSPersistentContainer = StorageProvider.shared.persistentContainer
    
    
    func getActivities(comletion: @escaping (ResponseAPI<[UserActivityEntity]>) -> Void) {
        comletion(.success([.init(distance: 10, name: "ruta 1"),
                            .init(distance: 20, name: "ruta 2"),
                            .init(distance: 30, name: "ruta 3"),
                            .init(distance: 40, name: "ruta 4"),
                            .init(distance: 50, name: "ruta 5"),
                            .init(distance: 60, name: "ruta 6"),
                            .init(distance: 70, name: "ruta 7"),
                            .init(distance: 80, name: "ruta 8"),
                            .init(distance: 90, name: "ruta 9")]))
    }
}
