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
    func getLocations()
    func getArtWork()
    func startAdventure()
    func saveAdventure() 
    var locationSubject: CurrentValueSubject<CLLocationProtocol, Never> {get set}
    var annotationsSubject: CurrentValueSubject<[ArtWorkModel], Never> {get set}
    var distanceOfAdventureSubject: CurrentValueSubject<CLLocationDistance, Never> {get set}
    var locationsSubject:  CurrentValueSubject<[CLLocationProtocol], Never> {get set}
}

class HomeViewModel: HomeViewModelProtocol {
    lazy var homeDataSource: HomeDataSourceProtocol = HomeDataSource()

    var locationSubject = CurrentValueSubject<CLLocationProtocol, Never>(CLLocation())
    var annotationsSubject = CurrentValueSubject<[ArtWorkModel], Never>([])
    var distanceOfAdventureSubject = CurrentValueSubject<CLLocationDistance, Never>(CLLocationDistance())
    var locationsSubject = CurrentValueSubject<[CLLocationProtocol], Never>([])
    func getLocation() {
        homeDataSource.getLocation(completion: {[weak self] response in
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
    
    func startAdventure() {
        homeDataSource.startAdventure {[weak self] response in
            switch response {
            case .success(let data):
                self?.distanceOfAdventureSubject.value = data
            case .failure(let error):
                ()
            }
            
        }
    }
    
    func saveAdventure() {
        homeDataSource.stopAdcenture()
    }
    
    func getLocations() {
        self.homeDataSource.getLocations {[weak self] response in
            switch response {
            case .success(let locations):
                self?.locationsSubject.value = locations
            case .failure:
                ()
            }
        }
    }
}
