//
//  ActivityRepository.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 19/07/21.
//

import Foundation
import CoreData
import GenericUtilities
import CoreDataHelp

protocol ActivityRepositoryProtocol: StorageAPI {
    func getAllActivities(text: String,
                          completion: @escaping (ResponseAPI<[ActivityEntity]>) -> Void)
}

class ActivityRepository: ActivityRepositoryProtocol {
    var persistentContainer: NSPersistentContainer = StorageProvider.shared.persistentContainer
    
    
    func getAllActivities(text: String,
                          completion: @escaping (ResponseAPI<[ActivityEntity]>) -> Void) {
        let fetchRequest: NSFetchRequest<ActivityEntity> = ActivityEntity.fetchRequest()
        fetchRequest.sortDescriptors = [.init(key: #keyPath(ActivityEntity.date), ascending: false)]
        if !text.isEmpty{
            fetchRequest.predicate = NSPredicate(format: "%K CONTAINS[c] %@", #keyPath(ActivityEntity.name), text)
        }
        self.getDB(fetchRequest: fetchRequest, completion: completion)
        
    }
}
