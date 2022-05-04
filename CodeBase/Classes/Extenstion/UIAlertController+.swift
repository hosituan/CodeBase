//
//  UIAlertController+.swift
//  CodeBase
//
//  Created by Ho Si Tuan on 04/05/2022.
//

import Foundation
import UIKit

public extension UIAlertController {
    class func show(title: String, message: String, okButton: String = "OK", iconImage: String? = nil, _ complete: (() -> Void)? = nil)  {
        executeBlockOnMainIfNeeded {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: okButton, style: .default) { action in
                complete?()
            }
            
            alertController.addAction(action)
            UIViewController.topMostViewController()?.present(alertController, animated: true)
        }
    }
}
