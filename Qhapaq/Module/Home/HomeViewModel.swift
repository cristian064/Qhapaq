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
    func getArtWork()
    var locationSubject: CurrentValueSubject<CLLocationProtocol, Never> {get set}
    var annotationsSubject: CurrentValueSubject<[ArtWorkModel], Never> {get set}
}

class HomeViewModel: HomeViewModelProtocol {
    lazy var homeDataSource: HomeDataSourceProtocol = HomeDataSource()

    var locationSubject = CurrentValueSubject<CLLocationProtocol, Never>(CLLocation())
    var annotationsSubject = CurrentValueSubject<[ArtWorkModel], Never>([])
    
    func getLocation() {
        homeDataSource.getLocations(completion: {[weak self] response in
            switch response {
            case .success(let location):
                self?.locationSubject.value = location
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func getArtWork() {
        homeDataSource.getArtWork {[weak self] response in
            switch response {
            case .success(let responseData):
                self?.annotationsSubject.value = responseData
            case .failure(let error):
                ()
            }
        }

    }
    
}
