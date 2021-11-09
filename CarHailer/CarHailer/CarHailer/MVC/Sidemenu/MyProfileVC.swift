//
//  MyProfileVC.swift
//  CarHailer
//
//  Created by Nikunj on 05/12/20.
//  Copyright © 2020 Nikunj M. All rights reserved.
//

import UIKit
import Alamofire

class MyProfileVC: SideBaseViewController {
    
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtMobileNumber: UITextField!
    @IBOutlet var txtAddress: UITextView!
    
    @IBOutlet var btnSave: UIButton!
    
    var editButtonn : UIBarButtonItem!
    var isEdit : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.editButtonn = UIBarButtonItem.init(
            title: "Edit",
            style: .done,
            target: self,
            action: #selector(rightButtonAction))
        
        self.editButtonn.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem =  self.editButtonn
        self.getDataToServer()
    }
    
    @objc func rightButtonAction() {
        if(isEdit){
            self.editButtonn.title = "Edit"
            self.isEdit = false
            self.setUserData()
        } else {
            self.editButtonn.title = "Cancel"
            self.isEdit = true
            self.enableForEdit()
        }
    }
    func getDataToServer(){
        
        callWebservice1(URL: URL_GetProfile, httpMethod: .get, Params:nil, completion: { ( response : [String: Any]) in
            print("API response => ",response)
            
            if(response[IS_VALID] as! Int == 1) {
                let a : NSArray = response["Data"] as! NSArray
                if(a.count > 0){
                    let userData = asString(jsonDictionary: a[0] as! JSONDictionary)
                    print(userData)
                    Defaults.set(userData, forKey: constant.USER_DATA) //set login response to the userDefault
                    self.setUserData()
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
    
    func setUserData(){
        let userData : String = UserDefaults.standard.value(forKey: constant.USER_DATA) as! String
        let u : [String : Any] = userData.toJSON() as!  [String : Any]
        self.txtName.text = (u["name"] as! String)
        self.txtEmail.text = (u["email"] as! String)
        self.txtMobileNumber.text = (u["mobile"] as! String)
        self.txtAddress.text = (u["address"] as? String)
        
        
        appDelegate.mobileNumner = (u["mobile"] as! String)
        appDelegate.userName = (u["name"] as! String)
        appDelegate.userEmail = (u["email"] as! String)
        
        self.disableForEdit()
    }
    
    func disableForEdit(){
        self.txtName.isUserInteractionEnabled = false
        self.txtEmail.isUserInteractionEnabled = false
        self.txtMobileNumber.isUserInteractionEnabled = false
        self.txtAddress.isUserInteractionEnabled = false
        self.btnSave.isHidden = true
        self.isEdit = false
        self.editButtonn.title = "Edit"
        
    }
    func enableForEdit(){
        self.txtName.isUserInteractionEnabled = true
        self.txtEmail.isUserInteractionEnabled = true
        self.txtMobileNumber.isUserInteractionEnabled = false
        self.txtAddress.isUserInteractionEnabled = true
        self.btnSave.isHidden = false
    }
    
    @IBAction func onClickSave(){
        if(checkValidation()){
            let params = [
                "name": txtName!.text,
                "email": txtEmail!.text,
                "address": txtAddress!.text,
            ]
            
            callWebservice1(URL: URL_UpadateProfile, httpMethod: .post, Params:params as Parameters, completion: { ( response : [String: Any]) in
                print("API response => ",response)
                
                if(response[IS_VALID] as! Int == 1) {
                    let m : NSArray = response[strMessage] as! NSArray
                    if(m.count > 0){
                        let ms = m[0] as! [String: Any]
                        print(ms[strmessage] as! String)
                        displayToast(ms[strmessage] as! String)
                        self.getDataToServer()
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
        
    }
    func checkValidation() -> Bool {
        
        if(self.txtName.text == ""){
            displayToast(NAME_REQUIRED)
            return false
        } else  if(self.txtName.text!.count < 3){
            displayToast(NAME_MINLENGTH)
            return false
        }
        
        if(self.txtEmail.text == ""){
            displayToast(EMAIL_REQUIRED)
            return false
        } else  if (!txtEmail.text!.isValidEmail()){
            displayToast(EMAIL_INVALID)
            return false
        }
        
        if(self.txtAddress.text! == ""){
            displayToast(ADDRESS_REQUIRED)
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
