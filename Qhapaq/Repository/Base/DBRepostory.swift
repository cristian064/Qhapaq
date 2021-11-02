//
//  DBRepostory.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 1/11/21.
//

import Foundation
import CoreData

protocol DBRepository: AnyObject {
//    var persistentContainer: NSPersistentContainer
//    var viewContext: NSManagedObjectContext {get}
    func save(distance: Double, name: String, completion: @escaping (ResponseApi<Void>) -> Void )
    
}

extension DBRepository {
    
    func save(distance: Double, name: String,
              completion: @escaping (ResponseApi<Void>) -> Void)  {
        let activity = ActivityEntity(context: StorageProvider.shared.persistentContainer.viewContext)
        activity.distance = distance
        activity.date = Date()
        activity.name = name
        
        do {
            try StorageProvider.shared.persistentContainer.viewContext.save()
            completion(.success(()))
        } catch {
            completion(.failure(ErrorManager(code: 700)))
        }
        
    }
    
}
