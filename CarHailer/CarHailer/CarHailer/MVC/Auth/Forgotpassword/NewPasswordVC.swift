//
//  NewPasswordVC.swift
//  CarHailer
//
//  Created by Apple on 01/01/21.
//  Copyright © 2021 Nikunj M. All rights reserved.
//

import UIKit
import Alamofire

class NewPasswordVC: UIViewController {
 var strMobileNumber : String!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Set Left And Right Naviation Bar Items With Image
        addBlackBackButton()
        self.title = "New Password"
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
    
    func checkValidation() -> Bool {
          
          if (txtPassword.text == "") {
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
    @IBAction func onClickSumbit(sender:UIButton){
        if(checkValidation()){
            self.sendDataToServer()
        }
    }
    func sendDataToServer(){
        let p : Parameters = ["password": txtPassword.text!]
        callWebservice1(URL: URL_UpdatePassword + strMobileNumber, httpMethod: .post, Params:p, completion: { (response : [String: Any])  in
            print("API response => ",response)
            if(response[IS_VALID] as! Int == 1) {
                displayToast("Your has been updated successfully.")
                self.navigationController?.popToRootViewController(animated:true)
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

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
