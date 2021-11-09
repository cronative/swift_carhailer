//
//  OTPVC.swift
//  CarHailer
//
//  Created by Munjiyasara Nikunj on 22/07/20.
//  Copyright © 2020 Nikunj Munjiyasara. All rights reserved.
//

import UIKit
import Alamofire

protocol OTPDismissDelegate {
    func verfiySuccess()
}

class OTPVC: UIViewController , UITextFieldDelegate{

 @IBOutlet var lblOtp : UILabel!
    var oDelegate: OTPDismissDelegate!
    var uuid: String!
    
    var signUpDic: Parameters!
    var sentOtp : String!
    var strMobileNumber : String!
    var strOTPType : String!
    
    @IBOutlet var stackView: OTPView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(signUpDic!)
        self.addBlackBackButton()
        self.title = "Verify OTP"
        self.lblOtp.text = "Please enter the Verification code sent to " + strMobileNumber

        // Do any additional setup after loading the view.
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       return self.textLimit(existingText: textField.text,
        newText: string,
        limit: 4)
    }
    
    
    private func textLimit(existingText: String?,
                           newText: String,
                           limit: Int) -> Bool {
        let text = existingText ?? ""
        let isAtLimit = text.count + newText.count <= limit
        return isAtLimit
    }
    
    @IBAction func onClickVerfify(sender: UIButton){
        print(self.stackView.textFieldArray)
        var strOTP = ""
        for i in self.stackView.textFieldArray {
            let textF: UITextField =  i as UITextField
            print(textF.text!)
            strOTP =  strOTP + textF.text!

        }
        
        print(strOTP)
        if(strOTP == ""){
            displayToast(OTP_REQUIRED)
        } else if(strOTP != sentOtp) {
            displayToast(OTP_INVALID)
        } else {
            if(strOTPType == "FP"){
                self.pushToNewPassword()
            } else {
            self.sendDataToServer()
            }
            
        }
    }
    
    func pushToNewPassword(){
        guard let vc = UIStoryboard.loadFromAuth(.NewPassword) as? NewPasswordVC else {return}
        vc.strMobileNumber = strMobileNumber
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickResendOTP(){
        
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
        callWebservice1(URL: URL_SendSms + strMobileNumber, httpMethod: .post, Params:params, completion: {  (response : [String: Any]) in
            print("API response => ",response)
            self.sentOtp = otp
            displayToast("OTP resent to your mobile number")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func sendDataToServer(){
        callWebservice1(URL: URL_SignUp, httpMethod: .post, Params:self.signUpDic, completion: { (response : [String: Any])  in
            print("API response => ",response)
            displayToast("You are successfully registered.")
            self.navigationController?.popToRootViewController(animated:true)
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

class OTPTextField: UITextField {
    var previousTextField: UITextField?
    var nextTextFiled: UITextField?
     
    override func deleteBackward() {
        text = ""
        textColor = .black
        previousTextField?.becomeFirstResponder()
    }
}

class OTPView: UIStackView {
 
    var textFieldArray = [OTPTextField]()
    var numberOfOTPdigit = 4
     
    override init(frame: CGRect) {
        super.init(frame: frame)
         
        setupStackView()
        setTextFields()
    }
     
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
        setTextFields()
    }
     
    //To setup stackview
    private func setupStackView() {
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .center
        self.distribution = .fillEqually
        self.spacing = 5
    }
     
    //To setup text fields
    private func setTextFields() {
        for i in 0..<numberOfOTPdigit {
            let field = OTPTextField()
         
            textFieldArray.append(field)
            addArrangedSubview(field)
            field.delegate = self
            field.backgroundColor = .lightGray
            field.layer.opacity = 0.5
            field.textAlignment = .center
            field.layer.shadowColor = UIColor.black.cgColor
            field.layer.shadowOpacity = 0.1
             
            i != 0 ? (field.previousTextField = textFieldArray[i-1]) : ()
            i != 0 ? (textFieldArray[i-1].nextTextFiled = textFieldArray[i]) : ()
        }
    }
}
 
extension OTPView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let field = textField as? OTPTextField else {
            return true
        }
        if !string.isEmpty {
            field.text = string
            field.resignFirstResponder()
            field.nextTextFiled?.becomeFirstResponder()
            return true
        }
        return true
    }
}
