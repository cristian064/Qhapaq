//
//  ArtWorkModel.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 24/07/21.
//

import Foundation
import MapKit

struct ArtWorkModel {
    let title: String
    let locationName: String
    let discipline: String
    let lat: Double
    let longitude: Double
    
    
    var annotation: Annotation {
        return .init(coordinate: .init(latitude: lat,
                                       longitude: longitude),
                     title: title,
                     locationName: locationName)
    }
}
