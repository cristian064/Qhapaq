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

protocol DetailUserActivityRepositoryProtocol: StorageDB {
    func getAdventureLocations(with name: String,
                               completion: @escaping (ResponseDB<[ActivityLocationEntity]>) -> Void)
    func deleteActivity(userDetailInfo: UserActivityModel,
                        completion: @escaping (ResponseDB<Void>) -> Void)
}

class DetailUserActivityRepository: DetailUserActivityRepositoryProtocol {
//    var storageProvider: StorageProviderProtocol =
    
    var storageProvider: StorageProviderProtocol = StorageProvider.shared
    func getAdventureLocations(with name: String,
                               completion: @escaping (ResponseDB<[ActivityLocationEntity]>) -> Void) {
        let fetchRequest: NSFetchRequest<ActivityLocationEntity> = ActivityLocationEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@",
                                             #keyPath(ActivityLocationEntity.activity.name),
                                             name)
        self.getDB(fetchRequest: fetchRequest, completion: completion)
    }
    
    func deleteActivity(userDetailInfo: UserActivityModel,
                        completion: @escaping (ResponseDB<Void>) -> Void) {
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
