//
//  UIViewController.swift
//  TabbarWithSideMenu
//
//  Created by Sunil Prajapati on 20/04/18.
//  Copyright © 2018 sunil.prajapati. All rights reserved.
//

import UIKit
import MFSideMenu

extension UIViewController {
    
    //Set Navigation Bar Item Image for TabBar
    func setNavigationBarItem() {
        guard let menuImage = UIImage(named: "ic_menu")else {
            print("Not found menu or notification image")
            return
        }
        
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: menuImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.onClickMenu))
        leftButton.tintColor = UIColor.black
               navigationItem.leftBarButtonItem = leftButton
//        addLeftBarButtonWithImage(menuImage)
//        addRightBarButtonWithImage(notificationImage)
    }
    
    
    
      func setBackButton() {
            guard let menuImage = UIImage(named: "ic_backarrow")else {
                print("Not found menu or notification image")
                return
            }
            
            let leftButton: UIBarButtonItem = UIBarButtonItem(image: menuImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.onClickBackButton))
            leftButton.tintColor = UIColor.black
                   navigationItem.leftBarButtonItem = leftButton
        }
    
    @objc func onClickBackButton()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupMenuBarButtonItems()
       {
           let tempViewController = self.navigationController?.viewControllers[0];
           if ((self.menuContainerViewController.menuState == MFSideMenuStateClosed) && (tempViewController != self))
           {
               
           }else{
               
           }
       }
       
       @objc func onClickMenu()
       {
           self.menuContainerViewController.toggleLeftSideMenuCompletion { () -> Void in
               self.setupMenuBarButtonItems()
           }
       }
    
    //Load the UIView using Nibname
    func loadFromNibNamed(_ nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    //Check current viewcontroller is presented, Pushed or not
    func isModal() -> Bool {
        if let navigationController = self.navigationController {
            if navigationController.viewControllers.first != self {
                return false
            }
        }
        if self.presentingViewController != nil {
            return true
        }
        if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController {
            return true
        }
        if self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        return false
    }
    
    //Get topViewController from UIApllication Window or Current Navigation Controller
    public func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
    
    
    
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center

        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }

        return spinnerView
    }

    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
    
    
}


extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}


extension UIImageView {
    func loadImageFromUrl(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
