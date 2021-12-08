//
//  DetailUserActivityRepository.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 7/11/21.
//

import Foundation

protocol DetailUserActivityRepositoryProtocol: DBRepository {
    func getAdventureLocations(with name: String,
                               completion: @escaping (ResponseApi<[ActivityLocationEntity]>) -> Void)
}

class DetailUserActivityRepository: DetailUserActivityRepositoryProtocol {
    
    func getAdventureLocations(with name: String, completion: @escaping (ResponseApi<[ActivityLocationEntity]>) -> Void) {
        self.getLocationOfAdventure(with: name,
                                   completion: completion)
    }
}

