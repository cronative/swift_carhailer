//
//  HomeVC.swift
//  CarHailer
//
//  Created by Nikunj on 05/12/20.
//  Copyright © 2020 Nikunj M. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.getAdImageFromServer()
    }
    
    func getAdImageFromServer(){
        callWebservice1(URL: URL_AdvertiseMent, httpMethod: .get, Params:nil, completion: { ( response : [String: Any]) in
                              print("API response => ",response)
            let _ : NSArray = response["Data"] as! NSArray
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
