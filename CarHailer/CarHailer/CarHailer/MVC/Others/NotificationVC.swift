//
//  NotificationVC.swift
//  CarHailer
//
//  Created by Nikunj on 13/12/20.
//  Copyright © 2020 Nikunj M. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {
    
    var objData = NSArray()
        @IBOutlet weak var tblView: UITableView!
        @IBOutlet weak var lblNoData : UILabel!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "Notifications"
             tblView.tableFooterView = UIView()
            // Do any additional setup after loading the view.
            getDataFromServer()
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addBackButton()
    }
        func getDataFromServer(){
            
            
            callWebservice1(URL: URL_NotificationList + appDelegate.userID, httpMethod: .get, Params:nil, completion: { ( response : [String: Any]) in
                print("API response => ",response)
                let a : NSArray = response["Data"] as! NSArray
                self.objData = a
                if(a.count > 0){
//                    self.objData = a[0] as! NSArray
                    self.objData = self.objData.reversed() as NSArray
                    self.tblView.reloadData()
                    self.lblNoData.isHidden = true
                    self.tblView.isHidden = false
                } else {
                    self.lblNoData.isHidden = false
                    self.tblView.isHidden = true
                  self.lblNoData.text = "No, Data found!"
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

    //MARK:- UITableViewDataSource Methods
    extension NotificationVC: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return objData.count
        }
         
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
            let cell :NotificaitonCell = tableView.dequeueReusableCell(withIdentifier: "NotificaitonCell") as! NotificaitonCell
            cell.showData(objDic: (self.objData[indexPath.row] as? [String: Any])!)
    //        cell.lblTitle?.text = leftMenu[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
    }

    //MARK:- UITableViewDelegate Methods
    extension NotificationVC: UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            return UIView()
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 0
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
//            guard let vc = UIStoryboard.loadFromOther("AdDetailsVC") as? AdDetailsVC else {return}
//            vc.objDic = self.objData[indexPath.row] as! [String: Any]
//            self.present(vc, animated: true)
           
        }
        
       
    }
