//
//  SelectTripVC.swift
//  CarHailer
//
//  Created by Apple on 16/12/20.
//  Copyright © 2020 Nikunj M. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class SelectTripVC: UIViewController, GooglePlaceDelegate {
    func onFavButtonSelected(strLocation: String, strPlaceID: String) {
        
    }
    
    

    
    
    @IBOutlet weak var lblPickUpLocation: UILabel!
      @IBOutlet weak var lblDropLocation: UILabel!
    
    @IBOutlet weak var btnCheapest: UIButton!
    @IBOutlet weak var btnFastest: UIButton!
    
     var btnTag : Int!

    var strPL : String!
    var strDL : String!
    
    var strPLID : String!
       var strDLID : String!
    
    
    var strPLLatitude :String!
    var strPLLongitude :String!
    var strDLLatitude :String!
    var strDLLongitude :String!
    
    
    var objData = [[String: Any]]()
    var objDefaultData = [[String: Any]]()
    
       @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblDropLocation.text = self.strDL
        self.lblPickUpLocation.text = self.strPL
        self.getDataFromServer()
        tblView.tableFooterView = UIView()
        self.title = "Select Your Trip"
        
        
        strPLLatitude  = ""
        strPLLongitude = ""
        strDLLatitude = ""
        strDLLongitude = ""
        
        
        addBackButton()
        self.getPLLatLong()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          self.addBackButton()
      }
    
    func getPLLatLong(){
        
        print("Place ID ", strPLID!)
        //            print("Place Name ", strPlace!)
        var input = GInput()
        input.keyword = strPLID
        GoogleApi.shared.callApi(.placeInformation , input: input) { (response) in
            if response.isValidFor(.placeInformation){
                print("response:::")
                let p =  response.data as? GApiResponse.PlaceInfo
                print(p!)
                let coordinates = CLLocationCoordinate2D(latitude:(p?.latitude)!
                    , longitude:(p?.longitude)!)
                print("Core location::: ", coordinates)
                self.strPLLatitude = "\((p?.latitude)!)"
                self.strPLLongitude = "\((p?.longitude)!)"
                
                self.getDLLatLong()
            }
            
        }
        //

        
    }
        
        
        func getLocationName(strText:String) -> String{
            
            let ss = strText.components(separatedBy: ",")
            if(ss.count > 0){
                let ss1 = ss[0].lowercased()
                 let replaced = ss1.replacingOccurrences(of: "singapore", with: "")
                return replaced
            } else {
                let ss1 = strText.lowercased()
                let replaced = ss1.replacingOccurrences(of: "singapore", with: "")
                return replaced
            }
            
        }
    
    func getDLLatLong(){
           
        print("Place ID ", strDLID!)
           //            print("Place Name ", strPlace!)
           var input = GInput()
           input.keyword = strDLID
           GoogleApi.shared.callApi(.placeInformation , input: input) { (response) in
               if response.isValidFor(.placeInformation){
                   print("response:::")
                   let p =  response.data as? GApiResponse.PlaceInfo
                   print(p!)
                   let coordinates = CLLocationCoordinate2D(latitude:(p?.latitude)!
                       , longitude:(p?.longitude)!)
                   print("Core location::: ", coordinates)
                self.strDLLatitude =  "\((p?.latitude)!)"
                self.strDLLongitude = "\((p?.longitude)!)"
               }
               
           }
           //
           
       }
       
    
    
    
    @IBAction func onClickLocationButton(sender:UIButton){
          self.btnTag = sender.tag
          guard let vc = UIStoryboard.loadFromOther("GooglePlaceVC") as? GooglePlaceVC else {return}
          vc.delegate = self
          vc.btnTag = self.btnTag
         
              self.present(vc, animated: true)
      }
      
    
    
    func getDataFromServer(){
        
        print("source ", self.strPL!)
        print("source ID", self.strPLID!)
        print("destination ", self.strDL!)
        print("destination ID ", self.strDLID!)
        print("Lat ", safeString(data: appDelegate.myLat!))
        print("Long ",safeString(data: appDelegate.myLong!))
        
        let dic :[String: Any] = [
            "source": self.strPL!,
            "destination":         self.strDL!,
            "source_placeid":      self.strPLID!,
            "destination_placeid":  self.strDLID!,
            "userlatlng":safeString(data: appDelegate.myLat!) + "_" + safeString(data: appDelegate.myLong!),
        ]
        

//
//        let url = CAB_API + "?source=" + self.strPL + "&destination=" + self.strDL + "&DestinationID=" + self.strDLID + "&SourceID=" + self.strPLID + "&UserLatLng=" + appDelegate.myLat! + "_" + appDelegate.myLong! + "&apikey=" + CAB_KEY;
//        print(url)
    
//        let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        
      let ll =  "http://54.179.118.36/Airdely/getprice?source=1%20elias%20green&destination=harbourfront%20centre&SourceID=ChIJ0e4CNAQ92jERy_T_mqOSB48&DestinationID=ChIJV8Xb91gZ2jER-WmSKEt5LN0&UserLatLng=33.6461824_73.0529792&apikey=45998b9e-3193-455c-94bd-93453ab80bc5"
        
        let l = "http://54.179.118.36/Airdely/getprice?source=" + self.getLocationName(strText: self.strPL!) + "&destination=" + self.getLocationName(strText: self.strDL!) + "&SourceID=" + self.strPLID! + "&DestinationID=" + self.strDLID! + "&UserLatLng=" + safeString(data: appDelegate.myLat!) + "_" + safeString(data: appDelegate.myLong!) + "&apikey=" + CAB_KEY
        
        let urlString = l.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)


        
        callWebservice2(URL: urlString, httpMethod: .get, Params:dic, completion: { ( response : [String: Any]) in
            print("API response => ",response)
            let allKeys = Array(response.keys) // for Dictionary
            print("All Keys ", allKeys)
            
            if(allKeys.count > 0){
                for k in allKeys {
                    print(k)
                    if(k != "Ziper"){
                        
                    
                    if((response[k] as? [String : Any]) != nil){
                        let el : [String: Any] = response[k] as! [String : Any]
                        
                        if(((el["result"] as AnyObject).count)! > 0){
                            let r : NSArray  = (el["result"] as? NSArray)!
                            for it in r {
                                let itt : [String: Any] = it as! [String: Any]
                                self.objData.append(itt)
                            }
                            print(r)
                        }
                    }
                        }
                    
                }
            }
            self.objDefaultData = self.objData
            self.tblView.reloadData()

//            let a : NSArray = response["Data"] as! NSArray
        }) { (error) in
            print(error.localizedDescription)
        }
              
          }
    
    @IBAction func onClickCheapestButton(sender:UIButton){
        if(sender.isSelected){
            sender.isSelected = false
            sender.backgroundColor = UIColor.clear
            self.setDefaultData()
        } else {
            if(self.btnFastest.isSelected){
                self.btnFastest.backgroundColor = UIColor.clear
                self.btnFastest.isSelected = false
            }
            sender.isSelected = true
            sender.backgroundColor = hexStringToUIColor(hex: "#DB4A39")
            self.sortDataByKey(sortKey: "Price")
        }
        
        
    }
    func setDefaultData(){
        
        self.objData  = self.objDefaultData
        self.tblView.reloadData()
    }
    
    func sortDataByKey(sortKey:String){
        
        
        let ss = self.objData.filter({safeString(data: $0[sortKey]!) != ""}).sorted {
                    let s1 :String = safeString(data: $0[sortKey]!)
                    let s2 :String = safeString(data: $1[sortKey]!)
//
            if(sortKey == "Price"){
                 let myInt1 = Double(s1) ?? 0
                 let myInt2 = Double(s2) ?? 0
                return myInt1 < myInt2
            }
                    return s1 < s2
                }
        
        let blankdata = self.objData.filter({safeString(data: $0[sortKey]!) == ""})
        
        
            
 
        self.objData  = ss
        if(blankdata.count > 0){
            for item in blankdata {
                self.objData.append(item)
            }
        }
        
        self.tblView.reloadData()
    }
    func sortWithKeys(_ dict: [String: Any]) -> [String: Any] {
        let sorted = dict.sorted(by: { $0.key < $1.key })
        var newDict: [String: Any] = [:]
        for sortedDict in sorted { newDict[sortedDict.key] = sortedDict.value }
        return newDict
        
    }
    
    
    
    
    @IBAction func onClickFastestButton(sender:UIButton){
        if(sender.isSelected){
            sender.isSelected = false
            sender.backgroundColor = UIColor.clear
            self.setDefaultData()
        } else {
            if(self.btnCheapest.isSelected){
                self.btnCheapest.backgroundColor = UIColor.clear
                self.btnCheapest.isSelected = false
            }
            sender.isSelected = true
            sender.backgroundColor = hexStringToUIColor(hex: "#DB4A39")
            self.sortDataByKey(sortKey: "WaitingTime")
        }
        
         
    }
    func setBorder(cell:UIView){
        cell.layer.borderWidth = 1
        cell.layer.borderColor = hexStringToUIColor(hex: "#DB4A39").cgColor
        cell.layer.cornerRadius = 5
    }
    func removeBorder(cell:UIView){
          cell.layer.borderWidth = 0
        cell.layer.borderColor = UIColor.clear.cgColor
          cell.layer.cornerRadius = 0
      
    }
    func onPlaceSelected(strLocation: String, strPlaceID: String) {
        if(self.btnTag == 1){
            self.lblPickUpLocation.text = strLocation
            self.lblPickUpLocation.accessibilityIdentifier = strPlaceID
        } else {
            self.lblDropLocation.text = strLocation
            self.lblDropLocation.accessibilityIdentifier = strPlaceID
        }
    }
    
    
    func onClickCell(objDic: [String: Any]){
        self.postDataFromServer(objDic: objDic)
        guard let appstoreLink = (objDic["IOS_app_url"] as? String) else {
            print("Invalid link")
            return}
        guard let appName = (objDic["Type"] as? String) else {
                   print("Invalid link")
                   return}
         var appScheme  = ""
         if (appstoreLink.contains("comfortdelgro-booking-app")){
                    appScheme = "ComfortDelGro"
         } else {
            appScheme = appName
        }
//        var appScheme  = ""
//        if (appstoreLink.contains("grab")){
//            appScheme = "Grab://"
//        }  else if (appstoreLink.contains("comfortdelgro-booking-app")){
//            appScheme = "COMFORTDELGRO://"
//        } else if (appstoreLink.contains("fastgo")){
//            appScheme =  "FastGo://"
//        } else if (appstoreLink.contains("tada-ride-hailing")){
//            appScheme = "tada://"
//        } else if (appstoreLink.contains("gojek")){
//            appScheme = "Gojek://"
//        } else if (appstoreLink.contains("")){
//             appScheme = "grab://"
//        } else if (appstoreLink.contains("")){
//             appScheme = "grab://"
//        } else if (appstoreLink.contains("")){
//             appScheme = "grab://"
//        }
//
        self.openApp(appName: appScheme, appStoreLink: appstoreLink, objDic: objDic)
        
    }
    
    
    func postDataFromServer(objDic: [String: Any]){
        
        let params : Parameters = ["mobile":appDelegate.mobileNumner!,"service_name":safeString(data: objDic["Type"]!) ,"from_location":self.lblPickUpLocation.text!,"to_location":self.lblDropLocation.text! , "duration":"","highest_amount":CAB_KEY,"trip_amount":safeString(data: objDic["Price"]!),"trip_date":Int(Date().timeIntervalSince1970),"image_url":safeString(data: objDic["Logo_url"]!)]
        
        
        callWebservice1(URL: URL_AddTripHistory, httpMethod: .post, Params:params, completion: { ( response : [String: Any]) in
            print("API response => ",response)
            let a : NSArray = response["Message"] as! NSArray
            if(a.count>0){
                let b :[String: Any] = a[0] as! [String : Any]
                displayToast(b["message"] as! String)
            }
            
//              if(a.count > 0){
//                  self.objData = a[0] as! NSArray
//              }
//              self.objData = self.objData.reversed() as NSArray
//              self.tblView.reloadData()
          }) { (error) in
              print(error.localizedDescription)
          }
          
      }
    
      
   
        
    
//    : grab://open?dropOffAddress=4%20Tampines%20Central%205,%20Singapore%20529510&dropOffLatitude=1.3524936&dropOffLongitude=103.9447179&pickUpAddress=2%20Jurong%20East%20Street%2021,%20Singapore%20609601&pickUpLatitude=1.3348154&pickUpLongitude=103.7468395&screenType=BOOKING&sourceID=&taxiTypeId=302&c=singapore&pid=website
    func openApp(appName:String , appStoreLink: String, objDic: [String: Any]) {
        
     
        
        var appScheme = "\(appName)://open"
        if(appName == "Grab"){
            appScheme =  "grab://open" + "?dropOffAddress=" + self.lblDropLocation.text! + "&dropOffLatitude=" + strDLLatitude +
                "&dropOffLongitude=" + strDLLongitude + "&pickUpAddress=" + self.lblPickUpLocation.text! + "&pickUpLatitude=" + strPLLatitude +
                "&pickUpLongitude=" + strPLLongitude + "&screenType=" + "BOOKING" + "&sourceID=" + "" +
                "&taxiTypeId=" + "302" + "&c=singapore&pid=website"
            appScheme = appScheme.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }else if(appName == "Tada"){
            appScheme =  "https://tada-rider.app.link/open" + "?dropOffAddress=" + self.lblDropLocation.text! + "&dropOffLatitude=" + strDLLatitude +
                "&dropOffLongitude=" + strDLLongitude + "&pickUpAddress=" + self.lblPickUpLocation.text! + "&pickUpLatitude=" + strPLLatitude +
                "&pickUpLongitude=" + strPLLongitude
            appScheme = appScheme.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }
        
        
//        appScheme = "grab://open?dropOffAddress=4%20Tampines%20Central%205,%20Singapore%20529510&dropOffLatitude=1.3524936&dropOffLongitude=103.9447179&pickUpAddress=2%20Jurong%20East%20Street%2021,%20Singapore%20609601&pickUpLatitude=1.3348154&pickUpLongitude=103.7468395&screenType=BOOKING&sourceID=&taxiTypeId=302&c=singapore&pid=website"
        
        print("aa >> ","grab://open?dropOffAddress=4%20Tampines%20Central%205,%20Singapore%20529510&dropOffLatitude=1.3524936&dropOffLongitude=103.9447179&pickUpAddress=2%20Jurong%20East%20Street%2021,%20Singapore%20609601&pickUpLatitude=1.3348154&pickUpLongitude=103.7468395&screenType=BOOKING&sourceID=&taxiTypeId=302&c=singapore&pid=website")
print("Deeplink >> ",appScheme)
        let appUrl = URL(string: appScheme)
        if UIApplication.shared.canOpenURL(appUrl! as URL){
            UIApplication.shared.open(appUrl!)
        } else {
            print("App not installed")
            print("Link: ", appStoreLink)
            let appUrl1 = URL(string: appStoreLink)!
            UIApplication.shared.open(appUrl1, options: [:], completionHandler: nil)
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
  extension SelectTripVC: UITableViewDataSource {
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return objData.count
      }
       
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
          let cell :TripResultCell = tableView.dequeueReusableCell(withIdentifier: "TripResultCell") as! TripResultCell
        cell.showData(objDic: (self.objData[indexPath.row]))
  //        cell.lblTitle?.text = leftMenu[indexPath.row]
        
        
        
        if(indexPath.row == 0){
            if(self.btnCheapest.isSelected){
                cell.lblTyppe.text = "Best Value"
                cell.triangleView.isHidden = false
                cell.lblTyppe.isHidden = false
                self.setBorder(cell: cell.cellContent)
            } else if(self.btnFastest.isSelected){
                cell.lblTyppe.text = "Fastest Ride"
                cell.triangleView.isHidden = false
                cell.lblTyppe.isHidden = false
                self.setBorder(cell: cell.cellContent)
            } else {
                cell.triangleView.isHidden = true
                cell.lblTyppe.text = ""
                cell.lblTyppe.isHidden = true
                self.removeBorder(cell: cell.cellContent)
            }
        } else {
            cell.triangleView.isHidden = true
            cell.lblTyppe.text = ""
            cell.lblTyppe.isHidden = true
            self.removeBorder(cell:cell.cellContent)
        }
       
          cell.selectionStyle = .none
          return cell
      }
  }




  //MARK:- UITableViewDelegate Methods
  extension SelectTripVC: UITableViewDelegate {
      
      func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
          return UIView()
      }
      
      func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          return 0
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dic: [String: Any] = self.objData[indexPath.row]
        print(dic)
        self.onClickCell(objDic: dic)
//        if( dic["IOS_app_url"]! as! String != ""){
//            if let url = URL(string: safeString(data:  dic["IOS_app_url"]! as! String)) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            }
//        }
        
          
//          guard let vc = UIStoryboard.loadFromOther("AdDetailsVC") as? AdDetailsVC else {return}
//          vc.objDic = self.objData[indexPath.row] as! [String: Any]
//          self.present(vc, animated: true)
         
      }
    
    
    
      
     
  }
