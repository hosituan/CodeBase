//
//  UIView+SetAction.swift
//  CodeBase
//
//  Created by Ho Si Tuan on 04/05/2022.
//

import Foundation
import UIKit

private var actionKey: Void?
private var actionLongPressKey: Void?
extension UIView {
    func setAction(action: (() -> ())?) {
        self.isUserInteractionEnabled = true
        self.action = action
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pressed))
        self.addGestureRecognizer(tapGesture)
    }

    private var action: (() -> ())? {
        get {
            return objc_getAssociatedObject(self, &actionKey) as? () -> ()
        }
        set {
            objc_setAssociatedObject(self, &actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @objc private func pressed() {
        action?()
    }
}

extension Array where Element: UIView {
    func setAction(action: (() -> ())?) {
        for view in self {
            view.setAction(action: action)
        }
    }
}
