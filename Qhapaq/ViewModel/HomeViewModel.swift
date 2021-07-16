//
//  HomeViewModel.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 15/07/21.
//

import Foundation
import Combine
import CoreLocation

protocol HomeViewModelProtocol: AnyObject {
    func getLocation()
}

class HomeViewModel: HomeViewModelProtocol {
    lazy var repository: HomeRepositoryProtocol = HomeRepository()
    
    
    func getLocation() {
        repository.getLocations(completion: {[weak self] response in
            switch response {
            case .success(let location):
                ()
            case .failure(let error):
                ()
            }
        })
    }
}
