//
//  HomeViewController.swift
//  CodeBase_Example
//
//  Created by Ho Si Tuan on 04/05/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import CodeBase

class HomeViewController: TableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hello"
        view.backgroundColor = .white
    }
    
    override func viewModel() -> BaseViewModel? {
        return HomeViewModel()
    }
    
    override func setup() {
        super.setup()
        setupTableView()
    }
    
    override func registerCell() {
        super.registerCell()
        tableView.registerCells(ExampleTableViewCell.self)
        
    }
    override func setupTableView() {
        super.setupTableView()
    }
}
