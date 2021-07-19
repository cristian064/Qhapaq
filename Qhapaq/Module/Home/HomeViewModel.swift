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
    var locationSubject: CurrentValueSubject<CLLocationProtocol, Never> {get set}
}

class HomeViewModel: HomeViewModelProtocol {
    lazy var repository: HomeRepositoryProtocol = HomeRepository()

    var locationSubject = CurrentValueSubject<CLLocationProtocol, Never>(CLLocation())
    
    
    func getLocation() {
        repository.getLocations(completion: {[weak self] response in
            switch response {
            case .success(let location):
                self?.locationSubject.value = location
            case .failure(let error):
                print(error)
            }
        })
    }
}
