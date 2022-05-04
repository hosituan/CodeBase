//
//  BaseTableViewCell.swift
//  CodeBase
//
//  Created by Ho Si Tuan on 04/05/2022.
//

import Foundation
import UIKit

open class BaseTableViewCell: UITableViewCell {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    
    open func setupView() {
        
    }
}
