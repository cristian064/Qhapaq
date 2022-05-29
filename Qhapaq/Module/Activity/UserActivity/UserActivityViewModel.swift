//
//  UserActivityViewModel.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 18/07/21.
//

import Foundation
import Combine

protocol UserActivityViewModelProtocol: AnyObject {
    var elementsSubject: CurrentValueSubject<Void, Never> {get set}
    var searchSubject: CurrentValueSubject<String, Never> {get set}
    var activity: ActivityRequest {get set}
    func getUserActivities()
    func searchRoute(with text: String?)
    func setupSubscribeActionFromUI()
    var elements: [UserActivityModel] { get set }
}

class UserActivityViewModel: UserActivityViewModelProtocol {
    var elementsSubject = CurrentValueSubject<Void, Never>(())
    
    var elements: [UserActivityModel] = []
    var searchSubject = CurrentValueSubject<String, Never>("")
    var cancellables = Set<AnyCancellable>()
    lazy var dataSourceManger = UserActivityDataSourceManager()
    var activity = ActivityRequest(text: "", pageNumber: 1, pageSize: 10)
    func getUserActivities() {
        dataSourceManger.getActivities(request: activity) {[weak self] response in
            switch response {
            case .success(let data):
                self?.setupData(data: data)
            case .failure(let error):
                ()
            }
        }
    }
    
    func setupData(data: UserActivityPaginated) {
        
        if data.pageNumber == 1 {
            self.elements = data.activities
        } else {
            self.elements.append(contentsOf: data.activities)
        }
        elementsSubject.send()
    }
    
    func searchRoute(with text: String?) {
//        dataSourceManger.getActivities(request: text ?? "") {[weak self] response in
//            switch response {
//            case .success(let responseData):
//                self?.elementsSubject.value = responseData
//            case .failure:
//                ()
//            }
//        }
    }
    
    func setupSubscribeActionFromUI() {
        searchSubject.debounce(for: 1, scheduler: DispatchQueue.main)
            .filter({$0.count > 2})
            .removeDuplicates()
            .sink {[weak self] text in
                self?.searchRoute(with: text)
            }.store(in: &cancellables)
    }
}
