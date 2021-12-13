//
//  DetailUserActivityRepository.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 7/11/21.
//

import Foundation
import CoreData
import GenericUtilities
import CoreDataHelp

protocol DetailUserActivityRepositoryProtocol: StorageAPI {
    func getAdventureLocations(with name: String,
                               completion: @escaping (ResponseAPI<[ActivityLocationEntity]>) -> Void)
}

class DetailUserActivityRepository: DetailUserActivityRepositoryProtocol {
    var persistentContainer: NSPersistentContainer = StorageProvider.shared.persistentContainer
    
    
    func getAdventureLocations(with name: String, completion: @escaping (ResponseAPI<[ActivityLocationEntity]>) -> Void) {
        let fetchRequest: NSFetchRequest<ActivityLocationEntity> = ActivityLocationEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@",
                                             #keyPath(ActivityLocationEntity.activity.name),
                                             name)
        self.getDB(fetchRequest: fetchRequest, completion: completion)
    }
    
    deinit{
        print("not retain cycle")
    }
}
