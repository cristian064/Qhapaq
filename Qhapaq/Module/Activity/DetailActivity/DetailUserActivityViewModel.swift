//
//  DetailUserActivityViewModel.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 7/11/21.
//

import Foundation

protocol DetailUserActivityViewModelProtocol: AnyObject {
    var userActivity: UserActivityModel {get}
    var adventureTitle: String {get}
}


class DetailUserActivityViewModel: DetailUserActivityViewModelProtocol {
    var userActivity: UserActivityModel
    var adventureTitle: String = "Detalle aventura"
    init(userActivity: UserActivityModel) {
        self.userActivity = userActivity
    }
}
