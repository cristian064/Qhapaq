//
//  UserActivityViewModel.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 18/07/21.
//

import Foundation
import Combine

protocol UserActivityViewModelProtocol {
    var elementsSubject: CurrentValueSubject<[UserActivityModel], Never> {get set}
    var searchSubject: CurrentValueSubject<String, Never> {get set}
    func getUserActivities()
    func searchRoute(with text: String?)
    func setupSubscribeActionFromUI()
}

class UserActivityViewModel: UserActivityViewModelProtocol {
    var elementsSubject = CurrentValueSubject<[UserActivityModel], Never>([])
    var searchSubject = CurrentValueSubject<String, Never>("")
    var cancellables = Set<AnyCancellable>()
    lazy var dataSourceManger = UserActivityDataSourceManager()
    
    
    
    
    
    func getUserActivities() {
        dataSourceManger.getActivities(text: "") {[weak self] response in
            switch response {
            case .success(let responseData):
                self?.elementsSubject.value = responseData
            case .failure:
                ()
            }
        }
    }
    
    
    func searchRoute(with text: String?) {
        dataSourceManger.getActivities(text: text ?? "") {[weak self] response in
            switch response {
            case .success(let responseData):
                self?.elementsSubject.value = responseData
            case .failure:
                ()
            }
        }
    }
    
    func setupSubscribeActionFromUI() {
        searchSubject.debounce(for: 1, scheduler: DispatchQueue.main)
            .filter({$0.count > 0})
            .removeDuplicates()
            .sink {[weak self] text in
                self?.searchRoute(with: text)
            }.store(in: &cancellables)
    }
}
