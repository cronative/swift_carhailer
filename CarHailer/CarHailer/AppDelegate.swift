//
//  AppDelegate.swift
//  CarHailer
//
//  Created by Apple on 03/12/20.
//  Copyright © 2020 Nikunj M. All rights reserved.
//

import UIKit
import CoreData
import MFSideMenu
import ObjectMapper
import IQKeyboardManagerSwift
import CoreLocation
import SDWebImageWebPCoder
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var objMFSidemenuVC = MFSideMenuContainerViewController()
        var objSideBarNav = UINavigationController()
       var objCustomTabbar = CustomTabbar()
    
    var userData = [String: Any]()
    var mobileNumner : String!
    var userName : String!
    var userEmail : String!
    var userID : String!
    
    var locationManager = CLLocationManager()
    var currentLocation : CLLocation!

    var myLat : String!
    var myLong : String!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
         self.window = UIWindow(frame: UIScreen.main.bounds)
          IQKeyboardManager.shared.enable = true
        checkUserLoggedInOrNot()
        GoogleApi.shared.initialiseWithKey(GOOGLE_KEY)
        
        let webPCoder = SDImageWebPCoder.shared
        SDImageCodersManager.shared.addCoder(webPCoder)
        // Initialize Google Mobile Ads SDK
        
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [
            kGADSimulatorID as! String
        ]
        
        
        // Initialize Google Mobile Ads SDK
        GADMobileAds.sharedInstance().start()
        

        
        myLat = ""
        myLong = ""
//        UIFont.overrideInitialize()
        return true
    }
    
     func checkUserLoggedInOrNot(){
            let isUserLogin = UserDefaults.standard.value(forKey: constant.IS_USER_LOGIN)
            if(isUserLogin != nil){
//                self.setHomeView()
                self.setLocationView()
            } else {
                self.setLoginView()
            }
        checkForTheLocation()
        }
    
        func setLocationView(){
                
                guard let vc = UIStoryboard.loadFromOther("FetchCurrentLocationVC") as? FetchCurrentLocationVC else {return}
                let nav : UINavigationController = UINavigationController(rootViewController:  vc)
            nav.navigationBar.isHidden = true
                nav.navigationBar.barTintColor = hexStringToUIColor(hex: Colors.primaryColor.rawValue)
                       UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                self.window!.rootViewController = nav
                        self.window!.makeKeyAndVisible()
            }
        
        func setLoginView(){
            let vc1 =  UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
            
            
//            guard let vc = UIStoryboard.loadFromAuth(.Login) as? LoginVC else {return}
            print(vc1)
    //         guard let vc = UIStoryboard.loadFromSideMenu(.Sidemenu) as? SidemenuVC else {return}
            let nav : UINavigationController = UINavigationController(rootViewController:  vc1)
//            nav.navigationBar.isHidden = true
            nav.navigationBar.barTintColor = hexStringToUIColor(hex: Colors.primaryColor.rawValue)
                   UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            self.window!.rootViewController = nav
                    self.window!.makeKeyAndVisible()
        }
        
        func setHomeView(){
            
            let userData : String = UserDefaults.standard.value(forKey: constant.USER_DATA) as! String
            self.userData = userData.toJSON() as!  [String : Any]
            self.mobileNumner = (self.userData["mobile"] as! String)
            self.userName = (self.userData["name"] as! String)
            self.userEmail = (self.userData["email"] as! String)
            self.userID = (self.userData["id"] as! String)
            print("userData > ", self.userData)
            
            self.objCustomTabbar = (UIStoryboard.load("CustomTabbar") as? CustomTabbar)!
                   guard let leftMenuViewController = UIStoryboard.load("SidemenuVC") as? SidemenuVC else {return}
                   self.objSideBarNav = UINavigationController(rootViewController:  self.objCustomTabbar)
               self.objSideBarNav.navigationBar.barTintColor = hexStringToUIColor(hex: Colors.barColor.rawValue)
                   objMFSidemenuVC = MFSideMenuContainerViewController.container(withCenter: self.objSideBarNav, leftMenuViewController: leftMenuViewController, rightMenuViewController: nil);
                   objMFSidemenuVC.leftMenuWidth = 300
                   window?.rootViewController = objMFSidemenuVC
                   window?.makeKeyAndVisible()
    
        }
    
    func changeRootView(to vc: UIViewController){
        guard let leftMenuViewController = UIStoryboard.load("SidemenuVC") as? SidemenuVC else {return}
        self.objSideBarNav = UINavigationController(rootViewController:  vc)
        self.objSideBarNav.navigationBar.barTintColor = hexStringToUIColor(hex: Colors.barColor.rawValue)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
         self.objSideBarNav.navigationBar.titleTextAttributes = textAttributes
        objMFSidemenuVC = MFSideMenuContainerViewController.container(withCenter: self.objSideBarNav, leftMenuViewController: leftMenuViewController, rightMenuViewController: nil);
        objMFSidemenuVC.leftMenuWidth = 300
        window?.rootViewController = objMFSidemenuVC
        window?.makeKeyAndVisible()
    }
        
    func applicationWillTerminate(_ application: UIApplication) {
        Defaults.set(false, forKey: constant.IS_SHOW_ONCE)
    }
    
    
    
   func checkForTheLocation(){
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    

    
    }
    

    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

