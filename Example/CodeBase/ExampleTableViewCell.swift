//
//  ExampleTableViewCell.swift
//  CodeBase_Example
//
//  Created by Ho Si Tuan on 04/05/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import CodeBase
import SnapKit

class ExampleTableViewCell: BaseTableViewCell {
    lazy var titleLabel = UILabel()
    override func setupView() {
        super.setupView()
        contentView.addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.text = "Example Row"
        titleLabel.textColor = .black
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(12)
            make.centerX.centerY.equalToSuperview()
        }
        
    }
}
