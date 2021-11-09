//
//  AddFavPlaceVC.swift
//  CarHailer
//
//  Created by Nikunj on 01/01/21.
//  Copyright © 2021 Nikunj M. All rights reserved.
//

import UIKit
import Alamofire

class AddFavPlaceVC: UIViewController {

    @IBOutlet var txtName: UITextField!
    @IBOutlet var lblLocation: UILabel!
    
    var strLocation : String!
    var strPlaceId : String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Favourite Place"
        addBackButton()
        // Do any additional setup after loading the view.
        self.lblLocation.text = strLocation
    }
    
    @IBAction func onClickSubmit(){
        if(checkValidation()){
            self.sendDataToServer()
        }
       }
    func checkValidation() -> Bool {
               
               if (txtName.text == "") {
                   displayToast(NAME_REQUIRED)
                   return false
               }  else if ((txtName.text?.count)! < 1) {
                   displayToast(NAME_MINLENGTH)
                   return false
               }
               return true
               
           }
    
    func sendDataToServer(){
        
        let p : Parameters = ["mobile":appDelegate.mobileNumner!,"name":txtName.text!,"location_address":strLocation!,"":"","lat":"","lng":"","placeid":strPlaceId!]
        callWebservice1(URL: URL_AddFavLocation , httpMethod: .post, Params:p, completion: {  (response : [String: Any]) in
            print("API response => ",response)
            displayToast("You favourite place added successfully")
            self.navigationController?.popToRootViewController(animated: true)
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
