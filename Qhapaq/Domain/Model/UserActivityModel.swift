//
//  UserActivityModel.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 19/07/21.
//

import Foundation
import MapKit

struct UserActivityPaginated: PaginationProtocol {
    var pageNumber: Int
    var pageSize: Int
    let activities: [UserActivityModel]
}


struct UserActivityModel {
    let distance: Double
    let name: String
    let date: Date
}

struct AdventureLocationModel: CLLocationProtocol {
    var coordinate: CLLocationCoordinate2D
}


