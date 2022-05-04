//
//  BaseViewController.swift
//  Pods
//
//  Created by Ho Si Tuan on 04/05/2022.
//

import UIKit
import RxSwift
protocol HideNavigationBarShadowable: AnyObject { }
open class BaseViewController: UIViewController {
    var onDeinit: (() -> Void)?
    deinit {
        print("deinit \(self)")
        onDeinit?()
    }
    
    // Rx Variables
    public let disposeBag = DisposeBag()
    
    open class func initFromDefaultXib() -> UIViewController {
        let className = NSStringFromClass(self) as NSString
        let nibName = className.pathExtension
        let bundle = Bundle.init(for: self.classForCoder())

        return self.init(nibName: nibName, bundle: bundle)
    }
    
    required override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupNotifies()
        observe()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideBackButtonTitle()
        
        // Hide navigation bar shadow if needed
        if self is HideNavigationBarShadowable {
            navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self is HideNavigationBarShadowable {
            navigationController?.navigationBar.setValue(false, forKey: "hidesShadow")
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
}

extension BaseViewController {
    
    func setupNotifies() {
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: Language.languageChangeNotification, object: nil)
    }
    
    func applyLocalize() {}
    
    @objc func languageDidChange() {
        applyLocalize()
    }
    
    @objc func userLoggedOut() {
        
    }
    
    func setup() {
        BaseImage.Navigation.backIcon = UIImage()
    }
    
    func observe() {
        
    }
    
    fileprivate func hideBackButtonTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.prompt = nil
    }

    func prefersBarHidden(for navigationController: UINavigationController) -> Bool {
        return false
    }
}

extension BaseViewController {
    func createCloseLeftNaviItem() {
        let buttonLeftMenu: UIBarButtonItem = UIBarButtonItem(image: BaseImage.Navigation.backIcon, style: .plain, target: self, action: #selector(didTapLeftCloseButton))
        buttonLeftMenu.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
        self.navigationItem.leftBarButtonItem = buttonLeftMenu
    }
    
    func createCloseLeftNaviItem(action: (() -> Void)?) {
        let buttonLeftMenu: UIBarButtonItem = UIBarButtonItem(image: BaseImage.Navigation.closeIcon, style: .plain, action: { action?() })
        buttonLeftMenu.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
        self.navigationItem.leftBarButtonItem = buttonLeftMenu
    }
    
    func createBackButton() {
        let backButton: UIBarButtonItem = UIBarButtonItem(image: BaseImage.Navigation.backIcon, style: .plain, target: self, action: #selector(didTapLeftCloseButton))
        backButton.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func createRightNaviItem(title: String, action: (() -> Void)?) {
        let buttonRightMenu = UIBarButtonItem(title: title, style: .plain,  action: { action?() })
        self.navigationItem.rightBarButtonItem = buttonRightMenu
    }
    
    func createRightNaviItem(title: String, color: UIColor, action: (() -> Void)?) {
        let buttonRightMenu = UIBarButtonItem(title: title, style: .done,  action: { action?() })
        buttonRightMenu.tintColor = color
        self.navigationItem.rightBarButtonItem = buttonRightMenu
    }
    
    func createRightNaviItem(image: UIImage?, action: (() -> Void)?) {
        let buttonRightMenu = UIBarButtonItem(image: image, style: .plain, action: { action?() })
        self.navigationItem.rightBarButtonItem = buttonRightMenu
    }
    
    func createLeftNaviItem(title: String, action: (() -> Void)?) {
        let buttonRightMenu = UIBarButtonItem(title: title, style: .plain,  action: { action?() })
        self.navigationItem.leftBarButtonItem = buttonRightMenu
    }
    
    @objc func didTapLeftCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func setCrossDissolveAndFullScreen() {
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .fullScreen
    }
    
    func setPopup() {
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overCurrentContext
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.setAction { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    // Add a child view controller, its whole view is embeded in the containerView
    open func addController(controller: UIViewController, containerView: UIView) {
        addChildViewController(controller)
        controller.view.frame = CGRect.init(origin: .zero, size: containerView.frame.size)
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
    }
    
    // To remove the current child view controller
    public func removeController(controller: UIViewController, containerView: UIView) {
        controller.willMove(toParentViewController: nil)
        controller.removeFromParentViewController()
        controller.view.removeFromSuperview()
        controller.didMove(toParentViewController: nil)
    }
}

extension UIViewController {
    class open func topMostViewController() -> UIViewController? {
        return UIViewController.topViewControllerForRoot(rootViewController: UIApplication.shared.keyWindow?.rootViewController)
    }
    
    class open func topViewControllerForRoot(rootViewController:UIViewController?) -> UIViewController? {
        guard let rootViewController = rootViewController else {
            return nil
        }
        
        if rootViewController is UINavigationController {
            let navigationController:UINavigationController = rootViewController as! UINavigationController
            return UIViewController.topViewControllerForRoot(rootViewController: navigationController.viewControllers.last)
            
        } else if rootViewController is UITabBarController {
            let tabBarController:UITabBarController = rootViewController as! UITabBarController
            return UIViewController.topViewControllerForRoot(rootViewController: tabBarController.selectedViewController)
            
        } else if rootViewController.presentedViewController != nil {
            return UIViewController.topViewControllerForRoot(rootViewController: rootViewController.presentedViewController)
        } else {
            return rootViewController
        }
    }
}
