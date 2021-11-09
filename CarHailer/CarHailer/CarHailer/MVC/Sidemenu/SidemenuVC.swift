//
//  SidemenuVC.swift
//  CarHailer
//
//  Created by Nikunj on 05/12/20.
//  Copyright © 2020 Nikunj M. All rights reserved.
//

import UIKit

import UIKit
import RAMAnimatedTabBarController
import MFSideMenu



class SidemenuVC: UIViewController {
    
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblMobile : UILabel!
    @IBOutlet weak var lblEmail : UILabel!
    @IBOutlet weak var imgProfile : UIImageView!
    
    var leftMenu = ["Home","My Profile"
                    ,"Favourite Places",
                    "Redeem History",
                    "Earning Opportunities",
                    "View Advertisement",
                    "Terms & Conditions",
                    "Privacy & Policy",
                    "Contact Us",
                    "Help & FAQs",
                    "Log Out"]
    
     var leftMenuImages = ["home",
                           "profile-inactive",
                           "heart-empty",
                           "cash",
                           "cash",
                           "help",
                           "tc","privacy","contact","help","logout"]
    
    
    
    
    @IBOutlet weak var tblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableFooterView = UIView()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setUserData()
    }
    func setUserData(){
        self.lblName.text = appDelegate.userName
        self.lblEmail.text = appDelegate.userEmail
        self.lblMobile.text = appDelegate.mobileNumner
    }
    
    //MARK:- Other Methods
      func changeMainViewController(to viewController: UIViewController) {
        let navObj =  self.menuContainerViewController.centerViewController as! UINavigationController
        navObj.pushViewController(viewController, animated: true)
        appDelegate.objMFSidemenuVC.setMenuState(MFSideMenuStateClosed, completion: { () -> Void in
                   
               })
      }
    
    func setNewRoot(to viewController: UIViewController) {
         let navObj =  self.menuContainerViewController.centerViewController as! UINavigationController
        navObj.viewControllers = [viewController]
//        navObj.setViewControllers([viewController], animated: true)
//         navObj.pushViewController(viewController, animated: true)
         appDelegate.objMFSidemenuVC.setMenuState(MFSideMenuStateClosed, completion: { () -> Void in
                    
                })
       }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK:- UITableViewDataSource Methods
extension SidemenuVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leftMenu.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell :SidemenuCell = tableView.dequeueReusableCell(withIdentifier: "SidemenuCell") as! SidemenuCell
        cell.lblTitle?.text = leftMenu[indexPath.row]
        cell.imgView.image = UIImage(named: leftMenuImages[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

//MARK:- UITableViewDelegate Methods
extension SidemenuVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let leftHeaderView = loadFromNibNamed(ViewID.leftHeaderView) as? LeftHeaderView else {
//            print("Left Header view not found")
//            return nil
//        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        guard let leftMenuItem = SideMenuItems(rawValue: leftMenu[indexPath.row]) else {
            print("Left Menu Item not found")
            return
        }
        
        switch leftMenuItem {
          
        case .Logout:
            self.showLogoutConfirmationAlert()
            break
        
        case .Home:
            guard let vc = UIStoryboard.loadFromTabs("CustomTabbar") as? CustomTabbar else {return}
            
                       appDelegate.changeRootView(to: vc)
            break
        case .MyProfile:
            guard let vc = UIStoryboard.loadFromSideMenu("MyProfileVC") as? MyProfileVC else {return}
            vc.title = "My Profile"
            appDelegate.changeRootView(to: vc)
            break
        case .FP:
            guard let vc = UIStoryboard.loadFromSideMenu("FavouritePlaces") as? FavouritePlaces else {return}
            vc.title = "Favourite Places"
                       appDelegate.changeRootView(to: vc)
            break
        case .RM:
            guard let vc = UIStoryboard.loadFromSideMenu("Redeem_History") as? Redeem_History else {return}
            vc.title = "Redeem History"
                       appDelegate.changeRootView(to: vc)
            break
        case .EO:
            guard let vc = UIStoryboard.loadFromSideMenu("EarningOpportunitiesVC") as? EarningOpportunitiesVC else {return}
             vc.title = "Earning Opportunities"
                       appDelegate.changeRootView(to: vc)
            break
        case .VA:
            guard let vc = UIStoryboard.loadFromSideMenu("ViewAdvertisementVC") as? ViewAdvertisementVC else {return}
             vc.title = "Advertisement"
                       appDelegate.changeRootView(to: vc)
            break
        case .TC:
            guard let vc = UIStoryboard.loadFromSideMenu("TermsConditionsVC") as? TermsConditionsVC else {return}
             vc.title = "Terms & Conditions"
                       appDelegate.changeRootView(to: vc)
            break
        case .PrivacyPolicy:
            guard let vc = UIStoryboard.loadFromSideMenu("PrivacyPolicyVC") as? PrivacyPolicyVC else {return}
             vc.title = "Privacy & Policy"
                       appDelegate.changeRootView(to: vc)
            break
        case .ContactUs:
            guard let vc = UIStoryboard.loadFromSideMenu("ContactVC") as? ContactVC else {return}
             vc.title = "Contact US"
                       appDelegate.changeRootView(to: vc)
            break
        case .FAQ:
            guard let vc = UIStoryboard.loadFromSideMenu("HelpVC") as? HelpVC else {return}
             vc.title = "Help & FAQs"
                       appDelegate.changeRootView(to: vc)
            break
        }
    }
    
    func showLogoutConfirmationAlert(){
        appDelegate.objMFSidemenuVC.setMenuState(MFSideMenuStateClosed, completion: { () -> Void in
                   
               })

        let refreshAlert = UIAlertController(title: "Attention", message: "Are you sure you want to log out?", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
              print("Handle Ok logic here")
            let domain = Bundle.main.bundleIdentifier!
                                  UserDefaults.standard.removePersistentDomain(forName: domain)
                                  UserDefaults.standard.synchronize()
            appDelegate.setLoginView()
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))

        present(refreshAlert, animated: true, completion: nil)
    }
}


