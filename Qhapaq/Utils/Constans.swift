//
//  Constans.swift
//  Qhapaq
//
//  Created by cristian ayala on 11/02/22.
//

import Foundation

struct Constans {
    
    struct Localizable {
        static let titleHomeMenu = "titleHomeMenu".localizable
        static let titleActivityMenu = "titleActivityMenu".localizable
    }
}

extension String {
    var localizable: String {
        return NSLocalizedString(self, comment: "")
    }
}

