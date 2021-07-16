//
//  HomeRepository.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 15/07/21.
//

import Foundation
import CoreLocation

public enum ResponseApi<T> {
    case success(T)
    case failure(ErrorManager)
}

public struct ErrorManager {
    
    let code: Int
    
    init(code: Int){
        self.code = code
    }
}


protocol HomeRepositoryProtocol: AnyObject {
    func getLocations(completion: @escaping (ResponseApi<CLLocation>)-> Void)
}

class HomeRepository: HomeRepositoryProtocol {
    lazy var locationProvider = LocationProvider()
    func getLocations(completion: @escaping (ResponseApi<CLLocation>)-> Void) {
        
        if let currentLocation = locationProvider.currentLocation  {
            completion(.success(currentLocation))
        }
        completion(.failure(.init(code: 1000)))
    }
    
    
}
