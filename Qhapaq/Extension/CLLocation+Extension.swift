//
//  CLLocation+Extension.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 16/07/21.
//

import Foundation
import CoreLocation

protocol CLLocationProtocol {
    var coordinate: CLLocationCoordinate2D { get }
}

extension CLLocation: CLLocationProtocol {
    
}
