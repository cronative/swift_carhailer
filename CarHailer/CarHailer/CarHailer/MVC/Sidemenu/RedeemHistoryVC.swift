//
//  Redeem History.swift
//  CarHailer
//
//  Created by Nikunj on 05/12/20.
//  Copyright © 2020 Nikunj M. All rights reserved.
//

import UIKit

class Redeem_History: SideBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getDataFromServer()
    }
    
    
    func getDataFromServer(){
        callWebservice1(URL: URL_RedeemHistory, httpMethod: .get, Params:nil, completion: { ( response : [String: Any]) in
            print("API response => ",response)
            let a : NSArray = response["Data"] as! NSArray
//            self.objData = a[0] as! NSArray
//            self.tblView.reloadData()
//            print("API response => ",self.objData)
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
