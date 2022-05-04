//
//  Config.swift
//  CodeBase_Example
//
//  Created by Ho Si Tuan on 04/05/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import CodeBase
class StaticConfig {
    static func config() {
        BaseImage.Navigation.backIcon = UIImage(systemName: "arrow.left")
        BaseImage.Navigation.closeIcon = UIImage(systemName: "xmark")
    }
}
