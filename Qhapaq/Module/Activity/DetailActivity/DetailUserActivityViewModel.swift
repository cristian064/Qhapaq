//
//  DetailUserActivityViewModel.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 7/11/21.
//

import Foundation
import Combine

protocol DetailUserActivityViewModelProtocol: AnyObject {
    var userActivity: UserActivityModel {get}
    var adventureTitle: String {get}
    func getAdventureLocations()
    var locationsOfAdventureSubject : CurrentValueSubject<[CLLocationProtocol], Never> {get set}
}


class DetailUserActivityViewModel: DetailUserActivityViewModelProtocol {
    var userActivity: UserActivityModel
    var adventureTitle: String = "Detalle aventura"
    let datasource: DetailUserActivityDataSourceProtocol = DetailUserActivityDataSource()
    var locationsOfAdventureSubject = CurrentValueSubject<[CLLocationProtocol], Never>([])
    init(userActivity: UserActivityModel) {
        self.userActivity = userActivity
    }
    
    
    func getAdventureLocations() {
        datasource.getAdventureLocations(with: userActivity.name,
                                         completion: {[weak self] responseDatasource in
            switch responseDatasource {
            case .success(let adventureModel):
                self?.locationsOfAdventureSubject.value = adventureModel
            case .failure(let error):
                ()
            }
        })
    }
    
    func deleteRecord() {
        datasource.deleteActivity(userDetailInfo: userActivity) {[weak self] responseDatasource in
            switch responseDatasource {
            case .success:
                ()
            case .failure:
                ()
            }
        }
    }
}
