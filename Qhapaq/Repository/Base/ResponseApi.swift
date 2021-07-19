//
//  ResponseApi.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 16/07/21.
//

import Foundation

public enum ResponseApi<T> {
    case success(T)
    case failure(ErrorManager)
}
