//
//  CellPresentable.swift
//  CodeBase
//
//  Created by Ho Si Tuan on 04/05/2022.
//

import Foundation
import UIKit

protocol Presentable {}
protocol CellPresentable: Presentable {
    var index: IndexPath { get set }
    var cellIdentifier: String { get set }
    var cellHeight: CGFloat { get set }
}

class CellPresentableRowViewModel: CellPresentable {
    var index: IndexPath
    
    var cellIdentifier: String
    
    var cellHeight: CGFloat
    
    init(cellIdentifier: String, cellHeight: CGFloat, index: IndexPath) {
        self.cellIdentifier = cellIdentifier
        self.cellHeight = cellHeight
        self.index = index
    }
    
}
protocol CellConfigurable {
    func setup(viewModel: CellPresentable)
}
