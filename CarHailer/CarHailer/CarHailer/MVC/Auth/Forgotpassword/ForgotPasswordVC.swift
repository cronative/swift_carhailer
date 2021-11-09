//
//  ForgotPasswordVC.swift
//  CarHailer
//
//  Created by Munjiyasara Nikunj on 26/06/20.
//  Copyright © 2020 Nikunj Munjiyasara. All rights reserved.
//

import UIKit
import Alamofire

class ForgotPasswordVC: UIViewController, CountryCodeDelegate {
 @IBOutlet var btnCountryCode: UIButton!
    @IBOutlet var txtPhoneNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           //Set Left And Right Naviation Bar Items With Image
           addBlackBackButton()
        self.title = "Forgot Password"
       }
    
    @IBAction func onClickCountryCode(sender:UIButton){
            guard let vc = UIStoryboard.loadFromOther("CountryCodeSelectVC") as? CountryCodeSelectVC else {return}
         vc.delegate = self
            self.present(vc, animated: true)
        }
    
    
    func checkValidation() -> Bool {
         if (txtPhoneNumber.text == "") {
              displayToast(MOBILE_NUMBER_REQUIRED)
              return false
          } else if (!txtPhoneNumber.text!.isValidMobile()){
              displayToast(MOBILE_INVALID)
              return false
          }
          return true
      }
    
    @IBAction func onClickSumbit(sender:UIButton){
         if(checkValidation()){
               self.checkMobileNumberAlreadyRegisteredOrNot()
         }
     }
     
     
     func onCountryCodeSelected(objDic : [String : Any]){
         print(objDic)
        self.btnCountryCode.setTitle(objDic["dial_code"] as? String, for: .normal)
     }
     func checkMobileNumberAlreadyRegisteredOrNot(){
              callWebservice1(URL: URL_IsUserExist + (btnCountryCode.titleLabel?.text)! +  txtPhoneNumber.text!, httpMethod: .get, Params:nil, completion: {(response : [String: Any]) in
                       print("API response => ",response)
                     if(response[IS_VALID] as! Int == 1) {
                       self.sendDataToServer()
                     } else{
                         
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
         
    
    func pushOtpScreen(otp: String){
         let mob: String = (btnCountryCode.titleLabel?.text)! +  txtPhoneNumber.text!
         guard let vc = UIStoryboard.loadFromAuth(.OtpVc) as? OTPVC else {return}
        vc.signUpDic = ["":""]
         vc.sentOtp = otp
         vc.strMobileNumber = mob
        vc.strOTPType = "FP"
         self.navigationController?.pushViewController(vc, animated: true)
         
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
