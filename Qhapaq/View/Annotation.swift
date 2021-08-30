//
//  Annotation.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 24/07/21.
//

import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let title: String?
    let locationName: String?
    
    init(coordinate: CLLocationCoordinate2D, title : String, locationName: String){
        self.coordinate = coordinate
        self.title = title
        self.locationName = locationName
        super.init()
    }
    
    var subtitle: String? {
        return locationName
      }
}
