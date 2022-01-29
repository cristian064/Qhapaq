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
    func deleteActivity(userDetailInfo: UserActivityModel,
                        completion: @escaping (ResponseAPI<Void>) -> Void)
}

class DetailUserActivityRepository: DetailUserActivityRepositoryProtocol {
    var persistentContainer: NSPersistentContainer = StorageProvider.shared.persistentContainer
    
    func getAdventureLocations(with name: String,
                               completion: @escaping (ResponseAPI<[ActivityLocationEntity]>) -> Void) {
        let fetchRequest: NSFetchRequest<ActivityLocationEntity> = ActivityLocationEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@",
                                             #keyPath(ActivityLocationEntity.activity.name),
                                             name)
        self.getDB(fetchRequest: fetchRequest, completion: completion)
    }
    
    func deleteActivity(userDetailInfo: UserActivityModel,
                        completion: @escaping (ResponseAPI<Void>) -> Void) {
        let deleteFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityEntity")
        let predicateDate = NSPredicate(format: "%K == %@",
                                        #keyPath(ActivityEntity.date),
                                        userDetailInfo.date as NSDate)
        let predicateName = NSPredicate(format: "%K == %@",
                                        #keyPath(ActivityEntity.name),
                                        userDetailInfo.name)
        deleteFetchRequest.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [predicateDate,
                                                                                          predicateName])
        
        self.deleteRecordDB(deleteFetchRequest: deleteFetchRequest,
                            completion: completion)
    }
}
