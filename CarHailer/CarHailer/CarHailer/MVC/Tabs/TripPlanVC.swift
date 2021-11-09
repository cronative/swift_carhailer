//
//  TripPlanVC.swift
//  CarHailer
//
//  Created by Nikunj on 05/12/20.
//  Copyright © 2020 Nikunj M. All rights reserved.
//

import UIKit
import ImageSlideshow
import CoreLocation
import Alamofire
import GoogleMobileAds

class TripPlanVC: TabBaseVC , GooglePlaceDelegate, GADBannerViewDelegate  {
    
    
    
  lazy var adBannerView: GADBannerView = {
       let adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
       adBannerView.adUnitID = "ca-app-pub-8741987551042063/4570609679"
       adBannerView.delegate = self
       adBannerView.rootViewController = self
       
       return adBannerView
   }()
    

    var objAds = NSArray()
      var imgSources = [SDWebImageSource]()
        @IBOutlet weak var sliderView: ImageSlideshow!
    
     @IBOutlet weak var lblPickUpLocation: UILabel!
     @IBOutlet weak var lblDropLocation: UILabel!
    
     var locationManager = CLLocationManager()
    
    /// The banner view.
    @IBOutlet weak var bannerView: UIView!
    
    var btnTag : Int!
    
    var currentPage :Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Plan Your Trip"
        
        // Request a Google Ad
        adBannerView.load(GADRequest())
        
        if(appDelegate.currentLocation != nil){
                  self.getPlaceName(location: appDelegate.currentLocation)
              } else {
                  self.checkLocation()
              }
        

      self.getAdImageFromServer()
        self.sliderView.slideshowInterval = 2.0
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TripPlanVC.didTap))
              self.sliderView.addGestureRecognizer(gestureRecognizer)
        let isUserLogin = UserDefaults.standard.value(forKey: constant.IS_SHOW_ONCE)
        self.sliderView.currentPageChanged = {
                   page in
//                   print("current page:", page)
            self.currentPage = page
               }
        if(isUserLogin != nil){
            let b = isUserLogin as! Bool
            if(!b){
                self.getBlastAdFromServer()
            }
        } else {
            self.getBlastAdFromServer()
        }
    
        
       
        }
    override func awakeFromNib() {
        super.awakeFromNib()

        self.tabBarItem.title = ""
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
    }

 

    @objc func didTap() {
        
        let obj: [String: Any] = self.objAds[self.currentPage] as! [String : Any]
        print(obj)
        self.postDataFromServer(objDic: obj)
        guard let url = URL(string: safeString(data: obj["url"]!)) else { return }
        UIApplication.shared.open(url)
        
//       self.sliderView.presentFullScreenController(from: self)
    }
    
    func postDataFromServer(objDic:[String:Any]){
            
        let params : Parameters = ["mobile":appDelegate.mobileNumner!,"reward_name":safeString(data: objDic["name"]!) ,"reward_points":safeString(data: objDic["points"]!),"reward_date":"" , "file_url":safeString(data: objDic["file_url"]!),"rewards_from":"Advertisement"]
            
            callWebservice1(URL: URL_AddRewards, httpMethod: .post, Params:params, completion: { ( response : [String: Any]) in
                print("API response => ",response)
                let a : NSArray = response["Message"] as! NSArray
                if(a.count>0){
                    let b :[String: Any] = a[0] as! [String : Any]
                    displayToast(b["message"] as! String)
                }
                  self.dismiss(animated: true, completion: nil)
                
    //              if(a.count > 0){
    //                  self.objData = a[0] as! NSArray
    //              }
    //              self.objData = self.objData.reversed() as NSArray
    //              self.tblView.reloadData()
              }) { (error) in
                  print(error.localizedDescription)
              }
              
          }
    
    
    
    
    func checkLocation(){
        locationManager.requestWhenInUseAuthorization()
        var currentLoc: CLLocation!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLoc = locationManager.location
            appDelegate.currentLocation = currentLoc
            if(currentLoc != nil){
                self.getPlaceName(location: currentLoc)
                          appDelegate.myLat = "\(currentLoc.coordinate.latitude)"
                          appDelegate.myLong = "\(currentLoc.coordinate.longitude)"
                                   print(currentLoc.coordinate.latitude)
                                   print(currentLoc.coordinate.longitude)
            }
          
                  }
    }
    
    func onFavButtonSelected(strLocation: String, strPlaceID: String) {
               guard let vc = UIStoryboard.loadFromOther("AddFavPlaceVC") as? AddFavPlaceVC else {return}
               vc.strLocation = strLocation
               vc.strPlaceId = strPlaceID
               self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getPlaceName(location:CLLocation){
        var input = GInput()
        let destination = GLocation.init(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                input.destinationCoordinate = destination
                GoogleApi.shared.callApi(.reverseGeo , input: input) { (response) in
                    if let places = response.data as? [GApiResponse.ReverseGio], response.isValidFor(.reverseGeo) {
                        DispatchQueue.main.async {
                            self.lblPickUpLocation.text = places.first?.formattedAddress
                            self.lblPickUpLocation.accessibilityLabel = places.first?.placeId
                        }
                    } else { print(response.error ?? "ERROR") }
                }
    }
        
        func getAdImageFromServer(){
            callWebservice1(URL: URL_AdvertiseMent, httpMethod: .get, Params:nil, completion: { ( response : [String: Any]) in
                                  print("API response => ",response)
                       let a : NSArray = response["Data"] as! NSArray
                self.objAds = (a[0] as? NSArray)!
                self.showSliderImages()
                              }) { (error) in
                                  print(error.localizedDescription)
                              }
            
        }
    
    
         func getBlastAdFromServer(){
            return
            callWebservice1(URL: URL_BLastAd, httpMethod: .get, Params:nil, completion: { ( response : [String: Any]) in
                print("API response => ",response)
                let a : NSArray = response["Data"] as! NSArray
                if(a.count > 0){
                    let b : NSArray =  (a[0] as? NSArray)!
                    if(b.count > 0){
                        let c :[String:Any] = b[0] as! [String: Any]
                        guard let vc = UIStoryboard.loadFromOther("AdDetailsVC") as? AdDetailsVC else {return}
                        vc.objDic = c
                        vc.img_or_video = "img"
                        Defaults.set(true, forKey: constant.IS_SHOW_ONCE)
                        self.present(vc, animated: true)
                    }
                }
//                 self.objAds = (a[0] as? NSArray)!
//                 self.showSliderImages()
                               }) { (error) in
                                   print(error.localizedDescription)
                               }
             
         }
    
      // MARK: - GADBannerViewDelegate methods
        
        func adViewDidReceiveAd(_ bannerView: GADBannerView!) {
            print("Banner loaded successfully")
            
            // Reposition the banner ad to create a slide down effect
            let translateTransform = CGAffineTransform(translationX: 0, y: -bannerView.bounds.size.height)
            bannerView.transform = translateTransform

            UIView.animate(withDuration: 0.5) {
                bannerView.transform = CGAffineTransform.identity
            }
            
            self.bannerView.addSubview(bannerView)
            
            
    //        UIView.animate(withDuration: 0.5) {
    //            self.tableView.tableHeaderView?.frame = bannerView.frame
    //            bannerView.transform = CGAffineTransform.identity
    //            self.tableView.tableHeaderView = bannerView
    //        }
            
        }
        
        func adView(_ bannerView: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
            print("Fail to receive ads")
            print(error)
            let responseInfo = error.userInfo[GADErrorUserInfoKeyResponseInfo] as? GADResponseInfo
  print(responseInfo)

        }
//  
    
 
    func showSliderImages(){
           self.imgSources.removeAll()
        for remoteImage in self.objAds {
            let a = remoteImage as? [String: Any]
            let url =  a!["file_url"] as? String
            imgSources.append(SDWebImageSource(urlString: url!)!)
           }
        
        
        
           sliderView.setImageInputs(imgSources)
       }
    
    @IBAction func onClickLocationButton(sender:UIButton){
        self.btnTag = sender.tag
        var placeId = ""
        var placeName = ""
        
        if(self.btnTag == 1){
            
            
            let al = self.lblPickUpLocation?.accessibilityLabel != nil ? self.lblPickUpLocation?.accessibilityLabel : ""
            
            
            
            placeName = self.lblPickUpLocation.text!
            placeId = al!
        } else {
            let al = self.lblDropLocation?.accessibilityLabel != nil ? self.lblDropLocation?.accessibilityLabel : ""
//            placeName = self.lblDropLocation.text!
            placeName = ""
            placeId = al!
        }
        
        self.openGoogelPlaceVC(bTag: self.btnTag, placeName: placeName, placeId: placeId)
    }
    func openGoogelPlaceVC(bTag:Int, placeName:String, placeId: String){
        guard let vc = UIStoryboard.loadFromOther("GooglePlaceVC") as? GooglePlaceVC else {return}
       
        vc.btnTag = bTag
        vc.strPlace = placeName
        vc.placeID = placeId
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
  
    
    func onPlaceSelected(strLocation: String, strPlaceID: String) {
        if(self.btnTag == 1){
            self.lblPickUpLocation.text = strLocation
            self.lblPickUpLocation.accessibilityLabel = strPlaceID
        } else {
            self.lblDropLocation.text = strLocation
            self.lblDropLocation.accessibilityLabel = strPlaceID
            self.goToTripResultView()
        }
    }
    
    func checkValidation() -> Bool {
           
           if(self.lblDropLocation.text! == ""){
               displayToast(DROP_INVALID)
               return false
           } else if(self.lblPickUpLocation.text == ""){
               displayToast(PICKUP_INVALID)
               return false
           }
           
           return true
           
       }
       
    
    
    @IBAction func onClickBtnSearch(sender:UIButton){
        self.goToTripResultView()
//        self.btnTag = sender.tag
       
        
//        vc.delegate = self
//        vc.btnTag = self.btnTag
//
//            self.present(vc, animated: true)
    }
    
    func goToTripResultView(){
        if(self.checkValidation())
               {
                   guard let vc = UIStoryboard.loadFromOther("SelectTripVC") as? SelectTripVC else {return}
                   vc.strPL = self.lblPickUpLocation.text
                   vc.strDL = self.lblDropLocation.text
                   vc.strDLID = self.lblDropLocation.accessibilityLabel
                   vc.strPLID = self.lblPickUpLocation.accessibilityLabel
                   self.navigationController?.pushViewController(vc, animated: true)
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
