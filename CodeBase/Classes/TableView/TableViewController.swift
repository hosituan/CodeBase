//
//  BaseViewController+TableView.swift
//  CodeBase
//
//  Created by Ho Si Tuan on 04/05/2022.
//

import Foundation
import UIKit
import SnapKit
public protocol TableViewSetupable: AnyObject {
    func registerCell()
    func setupTableView()
}
open class TableViewController: BaseViewController, TableViewSetupable {
    public var tableViewModel: TableViewModel?
    public let tableView = UITableView()
    @objc dynamic open func registerCell() {
        
    }
    @objc dynamic open func setupTableView() {
        view.addSubview(tableView)
        guard let viewModel = self.viewModel() as? TableViewModel else { return }
        self.tableViewModel = viewModel
        self.tableViewModel?.buildViewModels()
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        registerCell()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension TableViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableViewModel?.heightForRow(at: indexPath) ?? UITableView.automaticDimension
    }
}

extension TableViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewModel?.numberOfRow(in: section) ?? 0
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewModel?.numberOfSection() ?? 0
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = self.tableViewModel?.modelForRow(at: indexPath) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath)
        if let cell = cell as? CellConfigurable {
            cell.setup(viewModel: model)
        }
        return cell
    }
}
