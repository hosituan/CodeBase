//
//  UIBarButtonItem+Selector.swift
//  Golfull
//
//  Created by Hồ Sĩ Tuấn on 05/09/2021.
//

import Foundation
import UIKit

// StackOverFlow answer: https://stackoverflow.com/a/47159432
private var actionKey: Void?
extension UIBarButtonItem {

    private var _action: () -> () {
        get {
            return objc_getAssociatedObject(self, &actionKey) as! () -> ()
        }
        set {
            objc_setAssociatedObject(self, &actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    convenience init(title: String?, style: UIBarButtonItem.Style, action: @escaping () -> ()) {
        self.init(title: title, style: style, target: nil, action: #selector(pressed))
        self.target = self
        self._action = action
    }
    
    convenience init(image: UIImage?, style: UIBarButtonItem.Style, action: @escaping () -> ()) {
        self.init(image: image, style: style, target: nil, action: #selector(pressed))
        self.target = self
        self._action = action
    }

    @objc private func pressed(sender: UIBarButtonItem) {
        _action()
    }

}
