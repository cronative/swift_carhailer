//
//  AppHelper.swift
//  CarHailer
//
//  Created by Munjiyasara Nikunj on 26/06/20.
//  Copyright © 2020 Nikunj Munjiyasara. All rights reserved.
//

import UIKit
import MFSideMenu




extension UIViewController {

    
    //Set Navigation Bar Item Image for TabBar
    func addMenuButton() {
        guard let menuImage = UIImage(named: "ic_menu")else {
            print("Not found menu or notification image")
            return
        }
        
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: menuImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.onClickMenu))
        leftButton.tintColor = UIColor.white
               navigationItem.leftBarButtonItem = leftButton
    }
    
    func addNotificationButton() {
          guard let menuImage = UIImage(named: "notification_white")else {
              print("Not found menu or notification image")
              return
          }
          
          let leftButton: UIBarButtonItem = UIBarButtonItem(image: menuImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.onClickNotification))
          leftButton.tintColor = UIColor.white
                 navigationItem.rightBarButtonItem = leftButton
      }
    
    func addCartBtn(){
        
      
    }
    
    
    @objc func onClickNotification(){
        guard let vc = UIStoryboard.loadFromOther("NotificationVC") as? NotificationVC else {return}
               self.navigationController!.pushViewController(vc, animated: true)
    }
    
    
    
    
    
      func addBackButton() {
            guard let menuImage = UIImage(named: "back")else {
                print("Not found menu or notification image")
                return
            }
            
            let leftButton: UIBarButtonItem = UIBarButtonItem(image: menuImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.onClickBackButton))
            leftButton.tintColor = UIColor.white
                   navigationItem.leftBarButtonItem = leftButton
        }
    func addBlackBackButton() {
               guard let menuImage = UIImage(named: "black_back")else {
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





class SideBaseViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Set Left And Right Naviation Bar Items With Image
        addMenuButton()
    }
}

class TabBaseVC: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Set Left And Right Naviation Bar Items With Image
        addMenuButton()
        addNotificationButton()
    }
}

class BackViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Set Left And Right Naviation Bar Items With Image
        addBackButton()
    }
}


func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func GetDateByFormat(date:String , format:String ) -> NSString
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let oldDate = dateFormatter.date(from: date)

    let convertDateFormatter = DateFormatter()
    convertDateFormatter.dateFormat = format

    return convertDateFormatter.string(from: oldDate!) as NSString
}





@IBDesignable
class RoundedImageView: UIImageView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.shadowRadius = newValue
//            layer.masksToBounds = false
            clipsToBounds = true
        }
    }
}


@IBDesignable
class ViewWithBackgroundColor: UIView {
    @IBInspectable var hexColor: String {
        get {
            return hexColor
        }
        set {
            backgroundColor = hexStringToUIColor(hex: newValue)
        }
    }
}


@IBDesignable
class roundedButton: UIButton {
   @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.shadowRadius = newValue
            layer.masksToBounds = false
        }
    }
}

extension UIButton {
    @IBInspectable
    var cornerRadius1: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
       var borderWidth: CGFloat {
           get {
               return layer.borderWidth
           }
           set {
               layer.borderWidth = newValue
           }
       }
}






class DynamicHeightCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}


@IBDesignable
class CardView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 2

    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    
     @IBInspectable var borderColor: UIColor? = UIColor.black
    
     @IBInspectable var borderWidth: CGFloat = 0

    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)

        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        layer.borderColor = borderColor?.cgColor
        layer.borderWidth = borderWidth
    }

}



class DynamicHeightTableView: UITableView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}





class SSBadgeButton: UIButton {

 var badgeLabel = UILabel()

 var badge: String? {
    didSet {
        addBadgeToButon(badge: badge)
    }
 }

public var badgeBackgroundColor = UIColor.red {
    didSet {
        badgeLabel.backgroundColor = badgeBackgroundColor
    }
}

public var badgeTextColor = UIColor.white {
    didSet {
        badgeLabel.textColor = badgeTextColor
    }
}

public var badgeFont = UIFont.systemFont(ofSize: 12.0) {
    didSet {
        badgeLabel.font = badgeFont
    }
}

public var badgeEdgeInsets: UIEdgeInsets? {
    didSet {
        addBadgeToButon(badge: badge)
    }
}

override init(frame: CGRect) {
    super.init(frame: frame)
    addBadgeToButon(badge: nil)
}

func addBadgeToButon(badge: String?) {
    badgeLabel.text = badge
    badgeLabel.textColor = badgeTextColor
    badgeLabel.backgroundColor = badgeBackgroundColor
    badgeLabel.font = badgeFont
    badgeLabel.sizeToFit()
    badgeLabel.textAlignment = .center
    let badgeSize = badgeLabel.frame.size

    let height = max(18, Double(badgeSize.height) + 5.0)
    let width = max(height, Double(badgeSize.width) + 10.0)

    var vertical: Double?, horizontal: Double?
    if let badgeInset = self.badgeEdgeInsets {
        vertical = Double(badgeInset.top) - Double(badgeInset.bottom)
        horizontal = Double(badgeInset.left) - Double(badgeInset.right)

        let x = (Double(bounds.size.width) - 10 + horizontal!)
        let y = -(Double(badgeSize.height) / 2) - 10 + vertical!
        badgeLabel.frame = CGRect(x: x, y: y, width: width, height: height)
    } else {
        let x = self.frame.width - CGFloat((width / 2.0))
        let y = CGFloat(-(height / 2.0))
        badgeLabel.frame = CGRect(x: x, y: y, width: CGFloat(width), height: CGFloat(height))
    }

    badgeLabel.layer.cornerRadius = badgeLabel.frame.height/2
    badgeLabel.layer.masksToBounds = true
    addSubview(badgeLabel)
    badgeLabel.isHidden = badge != nil ? false : true
}

required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.addBadgeToButon(badge: nil)
    fatalError("init(coder:) has not been implemented")
}
}


let badgeSize: CGFloat = 20
let badgeTag = 9830384

func badgeLabel(withCount count: Int) -> UILabel {
        let badgeCount = UILabel(frame: CGRect(x: 0, y: 0, width: badgeSize, height: badgeSize))
        badgeCount.translatesAutoresizingMaskIntoConstraints = false
        badgeCount.tag = badgeTag
        badgeCount.layer.cornerRadius = badgeCount.bounds.size.height / 2
        badgeCount.textAlignment = .center
        badgeCount.layer.masksToBounds = true
        badgeCount.textColor = .white
        badgeCount.font = badgeCount.font.withSize(14)
        badgeCount.backgroundColor = .systemRed
        badgeCount.text = String(count)
        return badgeCount
    }


func badgeLabel1() -> UILabel {
    let badgeCount = UILabel(frame: CGRect(x: 0, y: 0, width: badgeSize, height: badgeSize))
    badgeCount.translatesAutoresizingMaskIntoConstraints = false
    badgeCount.tag = badgeTag
    badgeCount.layer.cornerRadius = badgeCount.bounds.size.height / 2
    badgeCount.textAlignment = .center
    badgeCount.layer.masksToBounds = true
    badgeCount.textColor = .white
    badgeCount.font = badgeCount.font.withSize(14)
    badgeCount.backgroundColor = .systemRed
//    badgeCount.text = String(count)
    return badgeCount
}



