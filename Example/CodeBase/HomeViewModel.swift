//
//  HomeViewModel.swift
//  CodeBase_Example
//
//  Created by Ho Si Tuan on 04/05/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import CodeBase
import UIKit

class HomeViewModel: TableViewModel {
    
    override func buildViewModels() {
        super.buildViewModels()
        self.buildingModels.append(CellPresentableRowViewModel(cellIdentifier: ExampleTableViewCell.className, cellHeight: UITableView.automaticDimension, index: nextIndex(in: 0)))
        self.buildingModels.append(CellPresentableRowViewModel(cellIdentifier: ExampleTableViewCell.className, cellHeight: UITableView.automaticDimension, index: nextIndex(in: 0)))
        self.buildingModels.append(CellPresentableRowViewModel(cellIdentifier: ExampleTableViewCell.className, cellHeight: UITableView.automaticDimension, index: nextIndex(in: 0)))
        self.viewModels.accept(buildingModels)
    }
}
