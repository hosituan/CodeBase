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

open class BaseViewModel: NSObject {
//    var apiService: RestCoachProtocol?
    public let disposeBag = DisposeBag()
    
    let onShowError = PublishSubject<String?>()
    let success = PublishSubject<Bool>()
    let isFetching = PublishSubject<Bool>()
    
    lazy var page: Int = 1
    lazy var isLoadMore: Bool = true // Use for check load more (still have data) or not
    lazy var isLoading: Bool = false // Use for check is call api status or call api is finished
    
    public override init() {
        //self.apiService = RestCoachAPIService()
    }
    

    
//    init(apiService: RestProtocol) {
//        if apiService is RestCoachProtocol, let service = apiService as? RestCoachProtocol {
//            self.apiService = service
//        }
//
//    }
}

public extension BaseViewModel {

}
