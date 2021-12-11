//
//  ErrorManager.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 16/07/21.
//

import Foundation

public struct ErrorManager: Error {
    
    let code: Int
    
    init(code: Int){
        self.code = code
    }
    
    init(error: Error) {
        self.code = 100
    }
}
