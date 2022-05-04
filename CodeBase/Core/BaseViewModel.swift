//
//  BaseViewModel.swift
//  CodeBase
//
//  Created by Ho Si Tuan on 04/05/2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class BaseViewModel: NSObject {
//    var apiService: RestCoachProtocol?
    public let disposeBag = DisposeBag()
    
    let onShowError = PublishSubject<String?>()
    let success = PublishSubject<Bool>()
    let isFetching = PublishSubject<Bool>()
    
    lazy var buildingModels = [CellPresentable]()
    let viewModels = BehaviorRelay<[CellPresentable]>(value: [])
    
    lazy var page: Int = 1
    lazy var isLoadMore: Bool = true // Use for check load more (still have data) or not
    lazy var isLoading: Bool = false // Use for check is call api status or call api is finished
    
    override init() {
        //self.apiService = RestCoachAPIService()
    }
    

    
//    init(apiService: RestProtocol) {
//        if apiService is RestCoachProtocol, let service = apiService as? RestCoachProtocol {
//            self.apiService = service
//        }
//
//    }
}

extension BaseViewModel {
    func buildViewModels() {
        self.buildingModels = []
        
    }
    
    func numberOfRow(in section: Int) -> Int {
        return self.viewModels.value.filter {
            $0.index.section == section
        }.count
    }
    
    func numberOfSection() -> Int {
        if let maxViewModelSection = viewModels.value.max(by: { $0.index.section < $1.index.section }) {
            return maxViewModelSection.index.section + 1
        }
        return 0
    }
    
    func modelForRow(at indexPath: IndexPath) -> CellPresentable? {
        return self.viewModels.value.filter {
            $0.index == indexPath
        }.first
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        return self.modelForRow(at: indexPath)?.cellHeight ?? UITableView.automaticDimension
    }

}
