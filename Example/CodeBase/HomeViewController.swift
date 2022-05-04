//
//  HomeViewController.swift
//  CodeBase_Example
//
//  Created by Ho Si Tuan on 04/05/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import CodeBase
import UIKit

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

extension HomeViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let model = tableViewModel?.modelForRow(at: indexPath) else { return }
        let nextVC = NextViewController()
        nextVC.title = model.cellIdentifier
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
