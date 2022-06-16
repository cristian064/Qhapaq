//
//  UserActivityModel.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 19/07/21.
//

import Foundation
import MapKit

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
}

struct AdventureLocationModel: CLLocationProtocol {
    var coordinate: CLLocationCoordinate2D
}


protocol PaginationProtocol {
    associatedtype Element
    var pageNumber: Int {get set}
    var pageSize: Int {get set}
    var pageTotal: Int {get set}
    var data: [Element] {get set}
}

struct ActivityRequest: PaginationRequestProtocol {
    var totalPage: Int
    let text: String
    var pageNumber: Int
    var pageSize: Int
}

protocol PaginationRequestProtocol {
    var pageNumber: Int {get set}
    var pageSize: Int {get set}
    var totalPage: Int {get set}
}
