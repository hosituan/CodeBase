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
    
    open func setup() {

    }
    
    open func observe() {
        
    }
    
    open func viewModel() -> BaseViewModel? {
        return nil
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

public extension BaseViewController {
    func setupNotifies() {
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: Language.languageChangeNotification, object: nil)
    }
    
    func applyLocalize() {}
    
    @objc func languageDidChange() {
        applyLocalize()
    }
    
    @objc func userLoggedOut() {
        
    }
    
    
    fileprivate func hideBackButtonTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.prompt = nil
    }

    func prefersBarHidden(for navigationController: UINavigationController) -> Bool {
        return false
    }
}

public extension BaseViewController {
    func createBackNaviItem() {
        let buttonLeftMenu: UIBarButtonItem = UIBarButtonItem(image: BaseImage.Navigation.backIcon, style: .plain, target: self, action: #selector(didTapBackButton))
        buttonLeftMenu.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationItem.leftBarButtonItem = buttonLeftMenu
    }
    
    func createCloseLeftNaviItem(action: (() -> Void)?) {
        let buttonLeftMenu: UIBarButtonItem = UIBarButtonItem(image: BaseImage.Navigation.closeIcon, style: .plain, action: { action?() })
        buttonLeftMenu.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
        self.navigationItem.leftBarButtonItem = buttonLeftMenu
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
    
    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
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
}
