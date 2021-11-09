//
//  SignupVC.swift
//  CarHailer
//
//  Created by Munjiyasara Nikunj on 26/06/20.
//  Copyright © 2020 Nikunj Munjiyasara. All rights reserved.
//

import UIKit
import  SkyFloatingLabelTextField
import Alamofire
import EzPopup


class SignupVC: UIViewController , CountryCodeDelegate{
    
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtConfirmPassword: UITextField!
    @IBOutlet var txtPhoneNumber: UITextField!
    @IBOutlet var txtPinCode: UITextField!
    
     @IBOutlet var btnCountryCode: UIButton!
    
     @IBOutlet var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.txtCode.placeholder = "Enter Code for Free \(RS_SIGN)110/-"
//        self.title = "Sign up"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Set Left And Right Naviation Bar Items With Image
        addBlackBackButton()
        self.title = "Sign Up"
        self.setSignUpButton()
    }
    
    func setSignUpButton(){
           // .Normal
           let myNormalAttributedTitle = NSAttributedString(string: "Have an account? ",
                                                            attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        let myNormalAttributedTitle1 = NSAttributedString(string: "Log In",
                                                                 attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
           let combination = NSMutableAttributedString()

        combination.append(myNormalAttributedTitle)
        combination.append(myNormalAttributedTitle1)
           
        self.btnSignUp.setAttributedTitle(combination, for: .normal)
    }
    @IBAction func onClickLogin(sender:UIButton){
        self.navigationController?.popViewController(animated: true)
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
    @IBAction func onClickBtnEye1(sender:UIButton){
           if(sender.isSelected){
               txtConfirmPassword.isSecureTextEntry = true
               sender.isSelected = false
           } else {
               txtConfirmPassword.isSecureTextEntry = false
               sender.isSelected = true
           }
       }

    
    @IBAction func onClickSignup(sender:UIButton){
        if(checkValidation()){
              self.checkMobileNumberAlreadyRegisteredOrNot()

        }
    }
    
    
    @IBAction func onClickCountryCode(sender:UIButton){
            guard let vc = UIStoryboard.loadFromOther("CountryCodeSelectVC") as? CountryCodeSelectVC else {return}
         vc.delegate = self
            self.present(vc, animated: true)
        }
     
    func onCountryCodeSelected(objDic : [String : Any]){
        print(objDic)
        self.btnCountryCode.setTitle(objDic["dial_code"] as? String, for: .normal)
    }
    
    func pushOtpScreen(otp: String){
        let mob: String = (btnCountryCode.titleLabel?.text)! +  txtPhoneNumber.text!
        
        let signUpParams : Parameters = ["name":txtName.text!,"mobile":mob,"password":txtPassword.text!,"email":txtEmail.text!]
        
        guard let vc = UIStoryboard.loadFromAuth(.OtpVc) as? OTPVC else {return}
        vc.signUpDic = signUpParams
        vc.sentOtp = otp
        vc.strMobileNumber = mob
        vc.strOTPType = "SU"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func checkMobileNumberAlreadyRegisteredOrNot(){
//        let params : Parameters = ["message":otp + " " + SMS_BODY]
        
              callWebservice1(URL: URL_IsUserExist + (btnCountryCode.titleLabel?.text)! +  txtPhoneNumber.text!, httpMethod: .get, Params:nil, completion: {(response : [String: Any]) in
                  print("API response => ",response)
                if(response[IS_VALID] as! Int == 1) {
                    let m : NSArray = response[strMessage] as! NSArray
                    if(m.count > 0){
                        let ms = m[0] as! [String: Any]
                        print(ms[strmessage] as! String)
                        displayToast(ms[strmessage] as! String)
                    }
                } else{
                    self.sendDataToServer()
                }
              }) { (error) in
                  print(error.localizedDescription)
              }
    }
     
    
    func sendDataToServer(){
        var fourDigitNumber: String {
            var result = ""
            repeat {
                result = String(format:"%04d", arc4random_uniform(10000) )
            } while Set<Character>(result).count < 4
            return result
        }
        
        let otp = fourDigitNumber
        print(otp)
        
        let params : Parameters = ["message":otp + " " + SMS_BODY]
        callWebservice1(URL: URL_SendSms + (btnCountryCode.titleLabel?.text)! +  txtPhoneNumber.text!, httpMethod: .post, Params:params, completion: {(response : [String: Any]) in
            print("API response => ",response)
            displayToast("OTP sent to your mobile number")
            self.pushOtpScreen(otp: otp)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func checkValidation() -> Bool {
        
        if (txtName.text == "") {
            displayToast(NAME_REQUIRED)
            return false
        }  else if ((txtName.text?.count)! < 3) {
            displayToast(NAME_MINLENGTH)
            return false
        } else if (txtEmail.text == "") {
            displayToast(EMAIL_REQUIRED)
            return false
        } else if (!txtEmail.text!.isValidEmail()){
            displayToast(EMAIL_INVALID)
            return false
        } else if (txtPhoneNumber.text == "") {
            displayToast(MOBILE_NUMBER_REQUIRED)
            return false
        } else if (!txtPhoneNumber.text!.isValidMobile()){
            displayToast(MOBILE_INVALID)
            return false
        } else  if (txtPassword.text == "") {
            displayToast(PASSWORD_REQUIRED)
            return false
        }  else if ((txtPassword.text?.count)! < 8) {
            displayToast(PASSWORD_MINLENGTH)
            return false
        } else if (txtPassword.text != txtConfirmPassword.text) {
            displayToast(PASSWORD_NOTMATCH)
            return false
        }
  
        
        return true
        
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
