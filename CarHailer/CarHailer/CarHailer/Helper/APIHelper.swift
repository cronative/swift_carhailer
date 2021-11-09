//
//  APIHelper.swift
//  CarHailer
//
//  Created by Munjiyasara Nikunj on 30/06/20.
//  Copyright © 2020 Nikunj Munjiyasara. All rights reserved.
//


import Foundation
import SVProgressHUD
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

typealias SuccessCompletionBlock = ((_ reponse : DataResponse<Any>) ->())
typealias ErrorCompletionBlock = ((_ reponse : DataResponse<Any>) ->())
typealias FailureCompletionBlock = ((_ error:Error?) ->())
//let group = DispatchGroup()
//Extension for Web service call
extension UIViewController {
    
    public func callWebservice<T: BaseMappable>(URL:String?, httpMethod: HTTPMethod, Params:Parameters?, completion:@escaping (T) -> Void,FailCompletionBlock:@escaping (Error) -> Void)
    {
        print("URL => ", URL!)
        print("HTTPMethod => ", httpMethod)
        if(Params != nil){
            print("PARAMS => ",Params!)
        }
        
        guard NetworkConnectivity.isConnectedToInternet() else{
//            self.view.showToast(toastMessage:.msgNetworkConnection, duration: 1.5)
            return
        }
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        
        let Header = ["Content-Type":"application/json"]
        
        Alamofire.request(URL!, method: httpMethod, parameters: Params, encoding: JSONEncoding.default, headers: Header).responseObject{ (response:DataResponse<T>) in
            //group.leave()
            //group.notify(queue: .main) {
//            print(response)
//            completion(response.result.value!)
            switch response.result {
            case .success(let value):
                completion(value)
                SVProgressHUD.dismiss()
                print(value)
            case .failure(let error):
              
                FailCompletionBlock(error)
                  print(error)
                SVProgressHUD.dismiss()
            }
        //}
        }
    }
    
    public func callWebservice1(URL:String?, httpMethod: HTTPMethod, Params:Parameters?, completion:@escaping ([String: Any]) -> Void,FailCompletionBlock:@escaping (Error) -> Void)
        {
            print("URL => ", URL!)
            print("HTTPMethod => ", httpMethod)
            if(Params != nil){
                print("PARAMS => ",Params!)
            }
            
            guard NetworkConnectivity.isConnectedToInternet() else{
    //            self.view.showToast(toastMessage:.msgNetworkConnection, duration: 1.5)
                return
            }
            SVProgressHUD.setDefaultMaskType(.black)
            SVProgressHUD.show()
            
            let Header = ["Content-Type":"application/json"]
            Alamofire.request(URL!, method: httpMethod, parameters: Params, encoding: JSONEncoding.default, headers: Header).responseJSON {
                (response) in
                print(response.result.value)
                switch response.result {
                          case .success(let value):
//                            guard let data = response.result.value as? [String: Any] else{
//                                return
//                            }
//                            guard let json = data["data"] as? [String: Any] else{
//                                                          return
//                                                      }
                            completion(value as! [String : Any])
                              SVProgressHUD.dismiss()
                              print(value)
                          case .failure(let error):
                              print(error)
                              SVProgressHUD.dismiss()
                          }
                
//                if(response.result.isSuccess){
//                    print(response.result.value)
//                } else {
//
//                }
            }
//            Alamofire.request(URL!, method: httpMethod, parameters: Params, encoding: JSONEncoding.default, headers: Header)
//                .responseObject{ (response:DataResponse<T>) in
//                //group.leave()
//                //group.notify(queue: .main) {
//                print(response)
//    //            completion(response.result.value!)
//                switch response.result {
//                case .success(let value):
//                    completion(value)
//                    SVProgressHUD.dismiss()
//                    print(value)
//                case .failure(let error):
//
//                    FailCompletionBlock(error)
//                      print(error)
//                    SVProgressHUD.dismiss()
//                }
//            //}
//            }
        }
    
    
       public func callWebservice2(URL:String?, httpMethod: HTTPMethod, Params:Parameters?, completion:@escaping ([String: Any]) -> Void,FailCompletionBlock:@escaping (Error) -> Void)
            {
                print("URL => ", URL!)
                print("HTTPMethod => ", httpMethod)
                if(Params != nil){
                    print("PARAMS => ",Params!)
                }
                
                guard NetworkConnectivity.isConnectedToInternet() else{
        //            self.view.showToast(toastMessage:.msgNetworkConnection, duration: 1.5)
                    return
                }
                SVProgressHUD.setDefaultMaskType(.black)
                SVProgressHUD.show()
                
                let Header = ["Content-Type":"application/json"]
                Alamofire.request(URL!, method: httpMethod, parameters: Params, encoding: URLEncoding.queryString, headers: Header).responseJSON {
                    (response) in
                    print(response.result.value)
                    switch response.result {
                              case .success(let value):
                                completion(value as! [String : Any])
                                  SVProgressHUD.dismiss()
                                  print(value)
                              case .failure(let error):
                                  print(error)
                                  SVProgressHUD.dismiss()
                              }
                }

            }
    
    public func callWebserviceArray<T: BaseMappable>(URL:String?, httpMethod: HTTPMethod, Params:Parameters?,Header:[String:String]?, completion:@escaping ([T]) -> Void){
        guard NetworkConnectivity.isConnectedToInternet() else{
//            self.view.showToast(toastMessage:.msgNetworkConnection, duration: 1.5)
            return
        }
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        //group.enter()
        Alamofire.request(URL!, method: httpMethod, parameters: Params, encoding: JSONEncoding.default, headers: Header).responseArray {(response:DataResponse<[T]>) in
            //group.leave()
            //group.notify(queue: .main) {
            switch response.result {
            case .success(let value):
                completion(value)
                SVProgressHUD.dismiss()
                print(value)
            case .failure(let error):
                print(error)
                SVProgressHUD.dismiss()
            }
            //}
        }
    }
}



// Internet connection check
class NetworkConnectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
