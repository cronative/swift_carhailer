//
//  FavouritePlaces.swift
//  CarHailer
//
//  Created by Nikunj on 05/12/20.
//  Copyright © 2020 Nikunj M. All rights reserved.
//

import UIKit
import Alamofire

class FavouritePlaces: SideBaseViewController, FavPlaceDelegate {

        var objData = NSArray()
            @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblNoData : UILabel!
            override func viewDidLoad() {
                super.viewDidLoad()
                self.title = "Favourite Places"
                 tblView.tableFooterView = UIView()
                // Do any additional setup after loading the view.
                getDataFromServer()
            }
            func getDataFromServer(){
                
                          
                callWebservice1(URL: URL_FavLocations, httpMethod: .get, Params:nil, completion: { ( response : [String: Any]) in
                               print("API response => ",response)
                    let a : NSArray = response["Data"] as! NSArray
                    if(a.count > 0){
                        self.objData = a[0] as! NSArray
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
                         self.objData = []
                    }
                    
                    self.tblView.reloadData()
    //                print("API response => ",self.objData)
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
        extension FavouritePlaces: UITableViewDataSource {
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return objData.count
            }
             
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
                let cell :FavPlaceCell = tableView.dequeueReusableCell(withIdentifier: "FavPlaceCell") as! FavPlaceCell
                cell.showData(objDic: (self.objData[indexPath.row] as? [String: Any])!)
                cell.delegate = self
        //        cell.lblTitle?.text = leftMenu[indexPath.row]
                
                let btnEdit :UIButton = cell.viewWithTag(22) as! UIButton
                btnEdit.accessibilityLabel = "\(indexPath.row)"
                btnEdit.addTarget(self, action:#selector(self.onClickEdit), for: .touchUpInside)
                
                let btnDelete :UIButton = cell.viewWithTag(23) as! UIButton
                btnDelete.accessibilityLabel = "\(indexPath.row)"
                btnDelete.addTarget(self, action:#selector(self.onClickDelete), for: .touchUpInside)
                
                
                
                cell.selectionStyle = .none
                return cell
            }
            
            @objc func onClickEdit(sender: UIButton) {
                  let dic :[String: Any] = self.objData[Int(sender.accessibilityLabel!)!] as! [String : Any]
                
                    let alertController = UIAlertController(title: "Location Name", message: "", preferredStyle:  UIAlertController.Style.alert)
                alertController.addTextField { (textField : UITextField!) -> Void in
                        textField.placeholder = "Enter new locaiton name"
                    textField.text = safeString(data: dic["name"]!)
                    }
                let saveAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { alert -> Void in
                        
//                        let secondTextField = alertController.textFields![1] as UITextField
                    })
                let cancelAction = UIAlertAction(title: "Update", style: UIAlertAction.Style.default, handler: {
                        (action : UIAlertAction!) -> Void in
                    
                    let firstTextField = alertController.textFields![0] as UITextField
                    
                    if(firstTextField.text != ""){
                        self.updateDataFromServer(locatioId:(dic["id"] as? String)! , name: firstTextField.text!)
                    } else if (firstTextField.text == "") {
                        displayToast(NAME_REQUIRED)
                    }  else if ((firstTextField.text?.count)! < 1) {
                        displayToast(NAME_MINLENGTH)
                    }
                })
                
                    alertController.addAction(saveAction)
                    alertController.addAction(cancelAction)
                    
                self.present(alertController, animated: true, completion: nil)
            }
            
            @objc func onClickDelete(sender: UIButton) {
                let refreshAlert = UIAlertController(title: "CarHailer", message: DELETE_CONFIRM, preferredStyle: UIAlertController.Style.alert)

                refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
                      print("Handle Ok logic here")
                }))

                refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                      print("Handle Cancel Logic here")
                    self.deleteDataFromServer(ind: Int(sender.accessibilityLabel!)!)
                }))

                present(refreshAlert, animated: true, completion: nil)
            }
            
            func deleteDataFromServer(ind:Int){
                
                let dic :[String: Any] = self.objData[ind] as! [String : Any]
                
                callWebservice1(URL: URL_DeleteLocation + (dic["id"] as? String)!, httpMethod: .get, Params:nil, completion: { ( response : [String: Any]) in
                    print("API response => ",response)
                    self.getDataFromServer()
                    let m : NSArray = response[strMessage] as! NSArray
                                                 if(m.count > 0){
                                                     let ms = m[0] as! [String: Any]
                                                     print(ms[strmessage] as! String)
                                                     displayToast(ms[strmessage] as! String)
                                                 }
//                    let a : NSArray = response["Data"] as! NSArray
//                    if(a.count > 0){
//                        self.objData = a[0] as! NSArray
//                    }
//
//                    self.tblView.reloadData()
                    //                print("API response => ",self.objData)
                }) { (error) in
                    print(error.localizedDescription)
                }
                
            }
            
            func updateDataFromServer(locatioId:String, name:String){
                            
                let dic: Parameters = ["name":name]
                            
                            callWebservice1(URL: URL_UL + locatioId, httpMethod: .post, Params:dic, completion: { ( response : [String: Any]) in
                                print("API response => ",response)
                                self.getDataFromServer()
                                let m : NSArray = response[strMessage] as! NSArray
                                if(m.count > 0){
                                    let ms = m[0] as! [String: Any]
                                    print(ms[strmessage] as! String)
                                    displayToast(ms[strmessage] as! String)
                                }
                            }) { (error) in
                                print(error.localizedDescription)
                            }
                            
                        }
                        
        }

        //MARK:- UITableViewDelegate Methods
        extension FavouritePlaces: UITableViewDelegate {
            
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
