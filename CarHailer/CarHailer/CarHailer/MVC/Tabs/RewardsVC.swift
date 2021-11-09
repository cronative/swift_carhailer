//
//  RewardsVC.swift
//  CarHailer
//
//  Created by Nikunj on 05/12/20.
//  Copyright © 2020 Nikunj M. All rights reserved.
//

import UIKit

class RewardsVC: TabBaseVC,RewardCellDelegate {
    
    var objData = NSArray()
        @IBOutlet weak var tblView: UITableView!
    var refreshControl = UIRefreshControl()
    
    var ap : NSNumber! = 0
    var rp : NSNumber! = 0
    var trp : String! = "0"

        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "Rewards"
             tblView.tableFooterView = UIView()
            // Do any additional setup after loading the view.
//            getDataFromServer()
            refreshControl.attributedTitle = NSAttributedString(string: "Reloading...")
            refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
            tblView.addSubview(refreshControl)
        }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(true)
          self.getDataFromServer()
      }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        self.getDataFromServer()
        refreshControl.endRefreshing()
    }
    override func awakeFromNib() {
          super.awakeFromNib()

          self.tabBarItem.title = ""
      }
        func getDataFromServer(){
            
                      
            callWebservice1(URL: URL_RewardHistory, httpMethod: .get, Params:nil, completion: { ( response : [String: Any]) in
                print("API response => ",response)
                let a : NSArray = response["Data"] as! NSArray
                let d: [String: Any] =  a[0] as! [String: Any]
                self.objData = d["reward_history"] as! NSArray
                self.rp = (d["redeemed_points"] as! NSNumber)
                self.trp = safeString(data: d["reward_points"]!) == "" ? "0" : safeString(data: d["reward_points"]!)
                self.objData = self.objData.reversed() as NSArray
                self.tblView.reloadData()
                print("API response => ",self.objData)
            }) { (error) in
                print(error.localizedDescription)
            }
            
        }
    
    func onClickRedeem() {
             guard let vc = UIStoryboard.loadFromOther("RedeemVC") as? RedeemVC else {return}
          //                  vc.objDic = self.objData[indexPath.row] as! [String: Any]
                  self.navigationController?.pushViewController(vc, animated: true)
      }
      
      func onClickRedeemHistory() {
             guard let vc = UIStoryboard.loadFromOther("RedeemVC") as? RedeemVC else {return}
          //                  vc.objDic = self.objData[indexPath.row] as! [String: Any]
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

    //MARK:- UITableViewDataSource Methods
    extension RewardsVC: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return objData.count + 1
        }
         
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if(indexPath.row == 0){
                let cell :RedeemCell = tableView.dequeueReusableCell(withIdentifier: "RedeemCell") as! RedeemCell
                cell.lblTRP.text = "\(self.trp!)"
                cell.lblRP.text = "\(self.rp!)"
                let v : Int = (Int(self.trp!)! - Int(truncating: self.rp!))
                cell.lblAP.text = "\(v)"
                cell.delegate = self
                if(self.objData.count > 0){
                    cell.lblRH.isHidden = false
                } else {
                    cell.lblRH.isHidden = true
                }
                cell.selectionStyle = .none
                return cell
            } else {
                let cell :RedeemHistoryCell = tableView.dequeueReusableCell(withIdentifier: "RedeemHistoryCell") as! RedeemHistoryCell
                cell.showData(objDic: (self.objData[indexPath.row - 1] as? [String: Any])!)
                //        cell.lblTitle?.text = leftMenu[indexPath.row]
                cell.selectionStyle = .none
                return cell
            }
            
        }
    }

    //MARK:- UITableViewDelegate Methods
    extension RewardsVC: UITableViewDelegate {
        
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
