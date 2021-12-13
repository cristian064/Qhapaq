//
//  DBRepostory.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 1/11/21.
//

import Foundation
import CoreData
import CoreDataHelp
import GenericUtilities

protocol DBRepository: StorageAPI {
    func save(distance: Double,
              name: String,
              locations: [CLLocationProtocol],
              completion: @escaping (ResponseAPI<Void>) -> Void )
    
}

extension DBRepository {
    
    func save(distance: Double,
              name: String,
              locations: [CLLocationProtocol],
              completion: @escaping (ResponseAPI<Void>) -> Void)  {
        let activity = ActivityEntity(context: StorageProvider.shared.persistentContainer.viewContext)
        activity.distance = distance
        activity.date = Date()
        activity.name = name
        
    
        locations.forEach { location in
            let locationEntity = ActivityLocationEntity(context: StorageProvider.shared.persistentContainer.viewContext)
            locationEntity.latitude = location.coordinate.latitude
            locationEntity.longitude = location.coordinate.longitude
            activity.addToLocations(locationEntity)
        }
        
        
        do {
            try StorageProvider.shared.persistentContainer.viewContext.save()
            completion(.success(()))
        } catch {
            StorageProvider.shared.persistentContainer.viewContext.rollback()
            completion(.failure(.init(code: 700)))
        }
        
    }
    
    func delete(data: ActivityEntity,
                completion: @escaping (ResponseAPI<Void>) -> Void) {
        StorageProvider.shared.persistentContainer.viewContext.delete(data)
        do {
            try StorageProvider.shared.persistentContainer.viewContext.save()
            completion(.success(()))
        } catch {
            completion(.failure(.init(code: 301)))
        }
    }
}
