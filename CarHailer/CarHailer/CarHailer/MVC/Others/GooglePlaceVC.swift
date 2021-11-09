//
//  GooglePlaceVC.swift
//  CarHailer
//
//  Created by Nikunj on 12/12/20.
//  Copyright © 2020 Nikunj M. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol GooglePlaceDelegate {
    func onPlaceSelected(strLocation : String, strPlaceID: String)
    func onFavButtonSelected(strLocation : String, strPlaceID: String)
}

class GooglePlaceVC: UIViewController {

   @IBOutlet weak var textfieldAddress: UITextField!
        @IBOutlet weak var tableviewSearch: UITableView!
        @IBOutlet weak var constraintSearchIconWidth: NSLayoutConstraint!
        @IBOutlet weak var searchView: UIView!
        @IBOutlet weak var mapview: MKMapView!
    
    var isFavPlaces : Bool = true
    
       @IBOutlet weak var lblTile: UILabel!
    var locationManager = CLLocationManager()
    var currentLocation : CLLocation!
    var placeID : String!
    var strPlace : String!
    var strPlaceID : String!
    var btnTag: Int!
    var autocompleteResults :[GApiResponse.Autocomplete] = []
    var delegate : GooglePlaceDelegate!

    var objFavData = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(self.btnTag == 1){
            self.lblTile.text = "Enter Pickup Location"
        } else {
            self.lblTile.text = "Enter Drop Location"
        }
        if(placeID != ""){
            self.getBounds()
        } else {
            self.fetchCurrentLocation()
        }
        self.textfieldAddress.text = strPlace
        self.getFavDataFromServer()
        
        
        
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    
    func getLocationName(mainText:String ,strText:String, address:String) -> String{
        
        
        let ss = strText.components(separatedBy: ",")
        let ss1 = ss[0].lowercased()
        _ = ss1 == "singapore" ? "" : ", " + ss[0]
//        return mainText +  sss
//        return strText + " " + mainText
        return address
//        return mainText
    }
    
    func fetchCurrentLocation(){
        locationManager.requestWhenInUseAuthorization()
        var currentLoc: CLLocation!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLoc = locationManager.location
            appDelegate.currentLocation = currentLoc
            if(currentLoc != nil){
                let c = CLLocationCoordinate2D(latitude: currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude)
                self.centerMapOnLocation(cen: c)
                print(currentLoc.coordinate.latitude)
                print(currentLoc.coordinate.longitude)
            }
            
        }
    }
    func getFavDataFromServer(){
                  
                            
                  callWebservice1(URL: URL_FavLocations, httpMethod: .get, Params:nil, completion: { ( response : [String: Any]) in
                                 print("FAV API response => ",response)
                      let a : NSArray = response["Data"] as! NSArray
                    if(a.count > 0){
                      self.objFavData = a[0] as! NSArray
                    } else {
                        self.objFavData = []
                    }
                    if(self.objFavData.count > 0){
                        self.searchView.isHidden = false
                        self.isFavPlaces = true
                    } else {
                        self.searchView.isHidden = true
                        self.isFavPlaces = true
                    }
                      self.tableviewSearch.reloadData()
      //                print("API response => ",self.objData)
                             }) { (error) in
                                 print(error.localizedDescription)
                             }
           
              }
    
    func getBounds(){
        print("Place ID ", placeID!)
        print("Place Name ", strPlace!)
        var input = GInput()
        let destination = GLocation.init(latitude: mapview.region.center.latitude, longitude: mapview.region.center.longitude)
        input.destinationCoordinate = destination
        input.keyword = placeID
        GoogleApi.shared.callApi(.placeInformation , input: input) { (response) in
            if response.isValidFor(.placeInformation){
                print("response:::")
                let p =  response.data as? GApiResponse.PlaceInfo
                print(p!)
                let coordinates = CLLocationCoordinate2D(latitude:(p?.latitude)!
                , longitude:(p?.longitude)!)
                print("Core location::: ", coordinates)
                self.centerMapOnLocation(cen: coordinates)
                        }
                
            }
//
        
    }
    
    func drawImageWithProfilePic(urlString:String, image: UIImage) -> UIImageView {

                           let imgView = UIImageView(image: image)
                           imgView.frame = CGRect(x: 0, y: 0, width: 90, height: 90)

                           let picImgView = UIImageView()
                           picImgView.sd_setImage(with:URL(string: urlString))
                           picImgView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                           imgView.addSubview(picImgView)

                           picImgView.center.x = imgView.center.x
                           picImgView.center.y = imgView.center.y-10
                           picImgView.layer.cornerRadius = picImgView.frame.width/2
                           picImgView.clipsToBounds = true
                           imgView.setNeedsLayout()
                           picImgView.setNeedsLayout()

                   //        let newImage = imageWithView(view: imgView)
                   //        return newImage

                           return imgView
               }

    
    @IBAction func onClickFav(){
        if((self.textfieldAddress.text?.isEmpty)!){
            displayToast("Select any location")
            return
        }
        self.delegate.onFavButtonSelected(strLocation: self.textfieldAddress.text!, strPlaceID: placeID)
        self.dismiss(animated: true, completion:nil)
//        self.pushToAddFavPlace(strLocation: self.textfieldAddress.text!, strPlaceId: placeID)
    }
    
    @objc func pushToAddFavPlace(sender:UIButton){
        let ind :Int? = Int(sender.accessibilityLabel!)
        self.strPlace = autocompleteResults[ind!].formattedAddress
                  self.placeID = autocompleteResults[ind!].placeId
          self.delegate.onFavButtonSelected(strLocation: strPlace, strPlaceID: placeID)
             self.dismiss(animated: true, completion:nil)
    }
    
    func centerMapOnLocation(cen: CLLocationCoordinate2D) {
       let region = MKCoordinateRegion(center: cen, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
       DispatchQueue.main.async {
           self.mapview.setRegion(region, animated: true)
           let annotation = MKPointAnnotation()
           annotation.coordinate = cen
           self.mapview.addAnnotation(annotation)
        self.mapview.delegate = self
       }
    }
    
        @IBAction func searchButtonPressed(_ sender: Any) {
            textfieldAddress.becomeFirstResponder()
        }
        func showResults(string:String){
            var input = GInput()
            input.keyword = string
            GoogleApi.shared.callApi(input: input) { (response) in
                if response.isValidFor(.autocomplete) {
                    DispatchQueue.main.async {
                        self.searchView.isHidden = false
                        self.autocompleteResults = response.data as! [GApiResponse.Autocomplete]
                        self.tableviewSearch.reloadData()
                    }
                } else { print(response.error ?? "ERROR") }
            }
        }
        func hideResults(){
            searchView.isHidden = true
            autocompleteResults.removeAll()
            tableviewSearch.reloadData()
        }
    
    @IBAction func onClickDone(sender: UIButton){
        self.delegate.onPlaceSelected(strLocation: textfieldAddress.text!, strPlaceID: self.placeID)
         self.dismiss(animated: true, completion:nil)
    }
    @IBAction func onClickClose(sender: UIButton){
              self.dismiss(animated: true, completion:nil)
    }
    }

    extension GooglePlaceVC : UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            hideResults() ; return true
        }
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let text = textField.text! as NSString
            let fullText = text.replacingCharacters(in: range, with: string)
            if fullText.count > 2 {
                self.isFavPlaces = false
                showResults(string:fullText)
            }else{
                hideResults()
            }
            return true
        }
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//            constraintSearchIconWidth.constant = 0.0 ;
            return true
        }
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//            constraintSearchIconWidth.constant = 38.0 ;
            return true
        }
    }
    extension GooglePlaceVC : MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
         
            
            var input = GInput()
            let destination = GLocation.init(latitude: mapview.region.center.latitude, longitude: mapview.region.center.longitude)
            input.destinationCoordinate = destination
            self.getAddressFromLatLon(pdblLatitude: "\(mapview.region.center.latitude)", withLongitude: "\(mapview.region.center.longitude)")
//            GoogleApi.shared.callApi(.reverseGeo , input: input) { (response) in
//                if let places = response.data as? [GApiResponse.ReverseGio], response.isValidFor(.reverseGeo) {
//                    DispatchQueue.main.async {
//                        if(self.strPlace != ""){
//                            print("Location info >> ", places.first?.stFormatting)
////                            self.textfieldAddress.text = places.first?.formattedAddress
//                            let st = places.first?.stFormatting
//                            let mainText =  places.first?.formattedAddress
//                            let subText =  st!["secondary_text"] as? String
//
////                        let st = subText.components(separatedBy: ",")
//
//                            if(subText != nil){
//                                self.textfieldAddress.text = self.getLocationName(mainText: mainText!, strText: subText!,address: places.first!.formattedAddress)
//
//                            } else {
//                                self.textfieldAddress.text = mainText
//                            }
//
//
//                            self.placeID = places.first?.placeId
//                        } else {
//                            //                            self.strPlace =  places.first?.formattedAddress
//                            let st = places.first?.stFormatting
//                            if(st!.count > 0){
//                                let mainText =  st!["main_text"] as? String
//                                let subText =  st!["secondary_text"] as? String
//                                self.strPlace = self.getLocationName(mainText: mainText!, strText: subText!,address: places.first!.formattedAddress)
//                            } else {
//                                  self.strPlace =  places.first?.formattedAddress
//                            }
//
//                            self.placeID = places.first?.placeId
//                        }
//                    }
//                } else { print(response.error ?? "ERROR") }
//            }
        }
        
        
        func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
            let lat: Double = Double("\(pdblLatitude)")!
            //21.228124
            let lon: Double = Double("\(pdblLongitude)")!
            //72.833770
            let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = lon

            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


            ceo.reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    let pm = placemarks! as [CLPlacemark]

                    if pm.count > 0 {
                        let pm = placemarks![0]
                        print(pm.country)
                        print(pm.locality)
                        print(pm.subLocality)
                        print(pm.thoroughfare)
                        print(pm.postalCode)
                        print(pm.subThoroughfare)
                        
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + ", "
                        }
                        if pm.postalCode != nil {
                            addressString = addressString + pm.postalCode! + " "
                        }


                        print(addressString)
                  }
            })

        }
        
        
        
        
    }





    extension GooglePlaceVC : UITableViewDataSource,UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if(isFavPlaces){
                return objFavData.count
            }
            return autocompleteResults.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell")
            let label = cell?.viewWithTag(1) as! UILabel
            let btn :UIButton = cell?.viewWithTag(2) as! UIButton
            btn.accessibilityLabel = "\(indexPath.row)"
            btn.addTarget(self, action:#selector(self.pushToAddFavPlace), for: .touchUpInside)
          
            if(isFavPlaces){
                let dic :[String: Any] = self.objFavData[indexPath.row] as! [String : Any]
                label.text = safeString(data: dic["name"]!)
                btn.isHidden = true
            } else {
//                label.text = autocompleteResults[indexPath.row].formattedAddress
                let st = autocompleteResults[indexPath.row].stFormatting
                         let mainText =  st["main_text"] as? String
                         let subText =  st["secondary_text"] as? String
                if(subText != nil){
label.text = self.getLocationName(mainText: mainText!, strText: subText!,address: autocompleteResults[indexPath.row].formattedAddress)
                } else {
                     label.text = mainText
                }
                    
                btn.isHidden = false
//                          print(autocompleteResults[indexPath.row].placeId)
            }
            return cell!
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            if(isFavPlaces){
                let dic :[String: Any] = self.objFavData[indexPath.row] as! [String : Any]
                textfieldAddress.text = safeString(data: dic["location_address"]!)
                  self.placeID = safeString(data: dic["placeid"]!)
                 textfieldAddress.resignFirstResponder()
                if let lat = Double( safeString(data: dic["lat"]!)),let lng = Double( safeString(data: dic["lng"]!)) {
                    self.searchView.isHidden = true
                    let center  = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                    self.mapview.setRegion(region, animated: true)
                    
                } else {
                    
                }
                return
            }
//            textfieldAddress.text = autocompleteResults[indexPath.row].formattedAddress
            print("Location info >> ",autocompleteResults[indexPath.row].stFormatting)
            let st = autocompleteResults[indexPath.row].stFormatting
            let mainText =  st["main_text"] as? String
            let subText =  st["secondary_text"] as? String
            textfieldAddress.text = self.getLocationName(mainText: mainText!, strText: subText!,address: autocompleteResults[indexPath.row].formattedAddress)
            self.placeID = autocompleteResults[indexPath.row].placeId
            textfieldAddress.resignFirstResponder()
            var input = GInput()
            input.keyword = autocompleteResults[indexPath.row].placeId
            GoogleApi.shared.callApi(.placeInformation,input: input) { (response) in
                if let place =  response.data as? GApiResponse.PlaceInfo, response.isValidFor(.placeInformation) {
                    DispatchQueue.main.async {
                        self.searchView.isHidden = true
                        if let lat = place.latitude, let lng = place.longitude{
                            let center  = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                            self.mapview.setRegion(region, animated: true)
                        }
                        self.tableviewSearch.reloadData()
                    }
                } else { print(response.error ?? "ERROR") }
            }
        }
        
        
    }
