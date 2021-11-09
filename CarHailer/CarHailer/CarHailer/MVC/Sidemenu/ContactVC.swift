//
//  ContactVC.swift
//  CarHailer
//
//  Created by Nikunj on 05/12/20.
//  Copyright © 2020 Nikunj M. All rights reserved.
//

import UIKit

class ContactVC: SideBaseViewController {

    @IBOutlet weak var lblContactName : UILabel!
    @IBOutlet weak var lblContactNumber : UILabel!
    @IBOutlet weak var lblMail : UILabel!
    @IBOutlet weak var lblAddress : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDataFromServer()
        // Do any additional setup after loading the view.
    }
    
    func getDataFromServer(){
           
                     
           callWebservice1(URL: URL_CU, httpMethod: .get, Params:nil, completion: { ( response : [String: Any]) in
                          print("API response => ",response)
               let a : NSArray = response["Data"] as! NSArray
            let c = a[0] as! [String: Any]
            self.lblContactName.text = c["contact_name"] as? String
            self.lblContactNumber.text = c["contact_no"] as? String
            self.lblMail.text = c["contact_email"] as? String
            self.lblAddress.text = c["address"] as? String
            
//               self.tblView.reloadData()
               
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
