//
//  DetailUserActivityRepository.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 7/11/21.
//

import Foundation
import CoreData
import GenericUtilities

protocol DetailUserActivityRepositoryProtocol: DBRepository {
    func getAdventureLocations(with name: String,
                               completion: @escaping (ResponseAPI<[ActivityLocationEntity]>) -> Void)
}

class DetailUserActivityRepository: DetailUserActivityRepositoryProtocol {
    var persistentContainer: NSPersistentContainer = StorageProvider.shared.persistentContainer
    
    
    func getAdventureLocations(with name: String, completion: @escaping (ResponseAPI<[ActivityLocationEntity]>) -> Void) {
        self.getLocationOfAdventure(with: name,
                                   completion: completion)
    }
    
    deinit{
        print("not retain cycle")
    }
}

