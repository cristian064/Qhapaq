//
//  QhapaqTests.swift
//  QhapaqTests
//
//  Created by cristian ayala on 2/02/22.
//

import XCTest
import CoreLocation
import GenericUtilities
import CoreDataHelp

@testable import Qhapaq
class QhapaqTests: XCTestCase {
    var viewModel: HomeViewModelProtocol!
    var homeMockDataSource: HomeDataSourceProtocol!
    
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
        homeMockDataSource = HomeMockDataSource()
        viewModel?.homeDataSource = homeMockDataSource
        
    }
    
    func test_GetLocation() {
        viewModel.getLocation()
        let location = AdventureLocationModel(coordinate: .init(latitude: 70, longitude: 70))
        XCTAssertEqual(viewModel.locationSubject.value.coordinate.latitude, location.coordinate.latitude)
        XCTAssertEqual(viewModel.locationSubject.value.coordinate.longitude, location.coordinate.longitude)
    }
    
    override func tearDown() {
        viewModel = nil
        homeMockDataSource = nil
        super.tearDown()
    }
}

class HomeMockDataSource: HomeDataSourceProtocol {
    
    func saveAdventure(name: String, distance: Double, locations: [CLLocationProtocol], completion: @escaping (ResponseDB<Void>) -> Void) {
        
    }
    

    
    var repository: HomeRepositoryProtocol
    
    init() {
        repository = HomeRepository()
    }
    
    func getLocation(completion: @escaping (ResponseAPI<CLLocationProtocol>) -> Void) {
        completion(.success(AdventureLocationModel(coordinate: .init(latitude: 70, longitude: 70))))

    }
    
    func getArtWork(completion: @escaping (ResponseAPI<[ArtWorkModel]>) -> Void) {
        
    }
    
    func startAdventure(completion: @escaping (ResponseAPI<CLLocationDistance>) -> Void) {
        
    }
    
    func getLocations(completion: @escaping (ResponseAPI<[CLLocationProtocol]>) -> Void) {
        
    }
    
    func saveAdventure(name: String, distance: Double, locations: [CLLocationProtocol], completion: @escaping (ResponseAPI<Void>) -> Void) {
        
    }
    
    func stopAdventure() {
        
    }
    
    
}
