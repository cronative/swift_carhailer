//
//  TripHistoryVC.swift
//  CarHailer
//
//  Created by Nikunj on 05/12/20.
//  Copyright © 2020 Nikunj M. All rights reserved.
//

import UIKit

class TripHistoryVC: TabBaseVC {
    
    var objData = NSArray()
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblNoData : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trip History"
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getDataFromServer()
    }
    
    override func awakeFromNib() {
          super.awakeFromNib()

          self.tabBarItem.title = ""
        
      }
    
    func getDataFromServer(){
        
        
        callWebservice1(URL: URL_GetTripHistory, httpMethod: .get, Params:nil, completion: { ( response : [String: Any]) in
            print("API response => ",response)
            let a : NSArray = response["Data"] as! NSArray
            if(a.count > 0){
                self.objData = a[0] as! NSArray
                self.objData = self.objData.reversed() as NSArray
                self.tblView.reloadData()
                self.lblNoData.isHidden = true
                self.tblView.isHidden = false
            } else {
                self.lblNoData.isHidden = false
                self.tblView.isHidden = true
                let m : NSArray = response[strMessage] as! NSArray
                if(m.count > 0){
                    let ms = m[0] as! [String: Any]
                    print(ms[strmessage] as! String)
                    self.lblNoData.text = (ms[strmessage] as! String)
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

//MARK:- UITableViewDataSource Methods
extension TripHistoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell :TripHistoryCell = tableView.dequeueReusableCell(withIdentifier: "TripHistoryCell") as! TripHistoryCell
        cell.showData(objDic: (self.objData[indexPath.row] as? [String: Any])!)
        //        cell.lblTitle?.text = leftMenu[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

//MARK:- UITableViewDelegate Methods
extension TripHistoryVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //          guard let vc = UIStoryboard.loadFromOther("AdDetailsVC") as? AdDetailsVC else {return}
        //          vc.objDic = self.objData[indexPath.row] as! [String: Any]
        //          self.present(vc, animated: true)
        
    }
    
    
}
