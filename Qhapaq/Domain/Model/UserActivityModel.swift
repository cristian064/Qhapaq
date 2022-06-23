//
//  UserActivityModel.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 19/07/21.
//

import Foundation
import MapKit
import GenericUtilities

struct UserActivityPaginated: PaginationProtocol {
    typealias Element = UserActivityModel
    var pageNumber: Int
    var pageSize: Int
    var pageTotal: Int
    var data: [UserActivityModel]
}


struct UserActivityModel {
    let distance: Double
    let name: String
    let date: Date
    var textView: String = ""
}

struct AdventureLocationModel: CLLocationProtocol {
    var coordinate: CLLocationCoordinate2D
}

struct ActivityRequest: PaginationRequestProtocol {
    var totalPage: Int
    let text: String
    var pageNumber: Int
    var pageSize: Int
}
