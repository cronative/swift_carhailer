//
//  LoginVC.swift
//  CarHailer
//
//  Created by Munjiyasara Nikunj on 26/06/20.
//  Copyright © 2020 Nikunj Munjiyasara. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Alamofire


class LoginVC: UIViewController, CountryCodeDelegate {
    
    @IBOutlet var txtMobileNumber: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
     @IBOutlet var btnCountryCode: UIButton!
    @IBOutlet var btnSignUp: UIButton!
    var phoneNumber: String!
    var email: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setSignUpButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setSignUpButton(){
           // .Normal
           let myNormalAttributedTitle = NSAttributedString(string: "New to CarHailer? ",
                                                            attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        let myNormalAttributedTitle1 = NSAttributedString(string: "Sign up now",
                                                                 attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
           let combination = NSMutableAttributedString()

        combination.append(myNormalAttributedTitle)
        combination.append(myNormalAttributedTitle1)
           
        self.btnSignUp.setAttributedTitle(combination, for: .normal)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        self.navigationController?.navigationBar.isHidden = false
    }
    

    /* // MARK: - Button event */
    @IBAction func onClickLogin(sender:UIButton){
//         appDelegate.setHomeView()
////        return
        if(checkValidation()){
//        appDelegate.setHomeView()
            self.sendDataToServer()
        }
       
    }
    
    @IBAction func onClickBtnEye(sender:UIButton){
        if(sender.isSelected){
            txtPassword.isSecureTextEntry = true
            sender.isSelected = false
        } else {
            txtPassword.isSecureTextEntry = false
            sender.isSelected = true
        }
    }
    
    
    func sendDataToServer(){
            
        let url = URL_Login + btnCountryCode.titleLabel!.text! + txtMobileNumber.text! + "/" + txtPassword.text!;
        
        callWebservice1(URL: url, httpMethod: .get, Params:nil, completion: { ( response : [String: Any]) in
            print("API response => ",response)
           
            if(response[IS_VALID] as! Int == 1) {
                 let a : NSArray = response["Data"] as! NSArray
                if(a.count > 0){
                    let userData = asString(jsonDictionary: a[0] as! JSONDictionary)
                    print(userData)
                    Defaults.set(userData, forKey: constant.USER_DATA) //set login response to the userDefault
                    Defaults.set(true, forKey: constant.IS_USER_LOGIN)
                    
                    
                    let userData1 : String = UserDefaults.standard.value(forKey: constant.USER_DATA) as! String
                    appDelegate.userData = userData1.toJSON() as!  [String : Any]
                    appDelegate.mobileNumner = (appDelegate.userData["mobile"] as! String)
                    appDelegate.userName = (appDelegate.userData["name"] as! String)
                    appDelegate.userEmail = (appDelegate.userData["email"] as! String)
                    appDelegate.userID = (appDelegate.userData["id"] as! String)
                    
                           
                    appDelegate.setLocationView()
                }
            } else {
                let m : NSArray = response[strMessage] as! NSArray
                if(m.count > 0){
                    let ms = m[0] as! [String: Any]
                    print(ms[strmessage] as! String)
                    displayToast(ms[strmessage] as! String)
                }
                
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
            
            
 
        }
    
    
    
    func checkValidation() -> Bool {
        
        if(self.txtMobileNumber.text! == ""){
            displayToast(MOBILE_NUMBER_REQUIRED)
            return false
        } else  if (!txtMobileNumber.text!.isValidMobile()) {
            displayToast(MOBILE_INVALID)
            return false
        }
        
        if(self.txtPassword.text == ""){
            displayToast(PASSWORD_REQUIRED)
            return false
        } else  if(self.txtPassword.text!.count < 8){
            displayToast(PASSWORD_MINLENGTH)
            return false
        }
        
        return true
        
    }
    
    @IBAction func onClickSignup(sender:UIButton){
        guard let vc = UIStoryboard.loadFromAuth(.Signup) as? SignupVC else {return}
               self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickForgotPassword(sender:UIButton){
        guard let vc = UIStoryboard.loadFromAuth(.ForgotPassword) as? ForgotPasswordVC else {return}
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func onClickClose(sender: UIButton){
          self.dismiss(animated: true, completion: nil)
      }

    
    
       @IBAction func onClickCountryCode(sender:UIButton){
           guard let vc = UIStoryboard.loadFromOther("CountryCodeSelectVC") as? CountryCodeSelectVC else {return}
        vc.delegate = self
           self.present(vc, animated: true)
       }
    
    func onCountryCodeSelected(objDic : [String : Any]){
        print(objDic)
        self.btnCountryCode.setTitle((objDic["dial_code"] as! String), for: .normal)
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
