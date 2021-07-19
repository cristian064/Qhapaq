//
//  HomeRepository.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 15/07/21.
//

import Foundation
import CoreLocation

protocol HomeRepositoryProtocol: AnyObject {
    func getLocations(completion: @escaping (ResponseApi<CLLocationProtocol>)-> Void)
}

class HomeRepository: HomeRepositoryProtocol {
    lazy var locationProvider = LocationProvider()
    func getLocations(completion: @escaping (ResponseApi<CLLocationProtocol>)-> Void) {
        guard let currentLocation = locationProvider.currentLocation else {
            return completion(.failure(.init(code: 1000)))
        }
        completion(.success(currentLocation))
    }
    
    
}
