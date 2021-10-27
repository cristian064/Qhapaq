//
//  StorageProvider.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 23/10/21.
//

import Foundation
import CoreData

class StorageProvider {
    
    let persistentContainer: NSPersistentContainer
    
    static var shared = StorageProvider()
    
    init() {
        
        persistentContainer = .init(name: "QapaqModel")
        
        
        persistentContainer.loadPersistentStores(completionHandler: { description, error in
            
            if let error = error {
                fatalError("something wrong happen \(error.localizedDescription)")
            }
        })
    }
}
