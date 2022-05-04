//
//  NSObject+ClassName.swift
//  CodeBase
//
//  Created by Ho Si Tuan on 04/05/2022.
//

import Foundation
import RxSwift

public protocol ClassName {
    static var className: String { get }
}
extension NSObject: ClassName {
    public static var className: String {
        return String(describing: self)
    }
}
