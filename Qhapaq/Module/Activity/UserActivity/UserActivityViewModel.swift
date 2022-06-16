//
//  UserActivityViewModel.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 18/07/21.
//

import Foundation
import Combine

protocol UserActivityViewModelProtocol: PaginationViewModelProtocol {
    var searchSubject: CurrentValueSubject<String, Never> {get set}
    func searchRoute(with text: String?)
    func setupSubscribeActionFromUI()
    var elements: [UserActivityModel] { get set }
}

class UserActivityViewModel: UserActivityViewModelProtocol {
    typealias PaginatedModel = UserActivityPaginated
    typealias Element = UserActivityModel
    var elements: [UserActivityModel] = []
    var isLoading: Bool = false
    var elementsSubject = CurrentValueSubject<Void, Never>(())
    
    var searchSubject = CurrentValueSubject<String, Never>("")
    var cancellables = Set<AnyCancellable>()
    lazy var dataSourceManger = UserActivityDataSourceManager()
    var requestData = ActivityRequest(text: "", pageNumber: 1, pageSize: 10)
    
    func loadData() {
        guard !isLoading else { return }
        isLoading = true
        dataSourceManger.getActivities(request: requestData) {[weak self] response in
            defer { self?.isLoading = false }
            switch response {
            case .success(let data):
                self?.setupData(with: data)
            case .failure(let error):
                ()
            }
        }
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

protocol PaginationViewModelProtocol: AnyObject {
    associatedtype PaginatedModel: PaginationProtocol
    associatedtype Element
    associatedtype RequestModel : PaginationRequestProtocol
    var requestData: RequestModel {get set}
    var elements: [Element] {get set}
    func setupData(with data: PaginatedModel)
    var elementsSubject: CurrentValueSubject<Void, Never> {get set}
    var isLoading: Bool {get set}
    func loadData()
    
}

extension PaginationViewModelProtocol {
    func setupData(with data: PaginatedModel) {
        guard let paginableElement = data.data as? [Element] else {
            elements = []
            return
        }
        requestData.pageNumber = data.pageNumber
        requestData.pageSize = data.pageSize
        if data.pageNumber == 1 {
            self.elements = paginableElement
        } else {
            self.elements.append(contentsOf: paginableElement)
        }
        elementsSubject.send()
    }
    
    func loadMoreData() {
            let pageNumber = (elements.count / requestData.pageSize).increment()
            requestData.pageNumber = pageNumber
            loadData()
    }
}
