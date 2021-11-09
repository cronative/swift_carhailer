//
//  FetchCurrentLocationVC.swift
//  CarHailer
//
//  Created by Apple on 16/12/20.
//  Copyright © 2020 Nikunj M. All rights reserved.
//

import UIKit
import CoreLocation

class FetchCurrentLocationVC: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()


    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        // Here you can check whether you have allowed the permission or not.
        
        
        if(locationManager.location == nil){
             appDelegate.setHomeView()
            return
        }
        
        if CLLocationManager.locationServicesEnabled()
        {
            switch(CLLocationManager.authorizationStatus())
            {
            case .authorizedAlways, .authorizedWhenInUse:
                print("Authorize.")
                let latitude: CLLocationDegrees = (locationManager.location?.coordinate.latitude)!
                let longitude: CLLocationDegrees = (locationManager.location?.coordinate.longitude)!
                appDelegate.currentLocation = locationManager.location
                appDelegate.myLat = "\(latitude)"
                appDelegate.myLong = "\(longitude)"
                let location = CLLocation(latitude: latitude, longitude: longitude) //changed!!!
                CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                    if error != nil {
                        return
                    }else if let country = placemarks?.first?.country,
                        let city = placemarks?.first?.locality , let ar =  placemarks?.first?.administrativeArea{
                        print(country)
                        print(ar)
                        print(city)
                        print(placemarks?.first!)
                        appDelegate.setHomeView()
                    }
                    else {
                    }
                })
                break

            case .notDetermined:
                print("Not determined.")
                appDelegate.setHomeView()
                self.showAlertMessage(messageTitle: "CarHailer", withMessage: "Location service is disabled!!")
                break

            case .restricted:
                print("Restricted.")
                self.showAlertMessage(messageTitle: "CarHailer", withMessage: "Location service is disabled!!")
                break

            case .denied:
                print("Denied.")
            }
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

    
    


    func showAlertMessage(messageTitle: NSString, withMessage: NSString) ->Void  {
        let alertController = UIAlertController(title: messageTitle as String, message: withMessage as String, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in

        }
        alertController.addAction(cancelAction)

        let OKAction = UIAlertAction(title: "Settings", style: .default) { (action:UIAlertAction!) in
            if let url = URL(string: "App-Prefs:root=Privacy&path=LOCATION/com.company.AppName") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
}


