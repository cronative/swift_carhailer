//
//  Constant.swift
//  CarHailer
//
//  Created by Munjiyasara Nikunj on 26/06/20.
//  Copyright © 2020 Nikunj Munjiyasara. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let mainWindow = UIApplication.shared.delegate?.window!
let Defaults = UserDefaults.standard
let RS_SIGN = "₹"
let CARTS_DATA = "CARTS_DATA"
enum NoDataMsg: String {
    
    case NO_HOMEWORK = "No Homework for this day!"
    case NO_TIMETABLE = "No Schedule for this day!"
    case NO_EXAM = "No Exam for this day!"
    case NO_CIRCULAR = "No Circular availabe"
    case NO_PLANNER = "No Monthly Planner for this month!"
    case NO_ACHIVEMENT =  "No Persionality Achivement!"
    
}










//http://159.65.2.160
var BASEURL = "http://68.183.233.197/mobileapp/api";
var GOOGLE_KEY = "AIzaSyDRayNymME_CkhX9QxN_B9hX8nf42gWz-s";
var NO_CORS = "https://cors-anywhere.herokuapp.com/";
var GOOGLE_PLACE_API = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
var COUNTRY_CODE = "SG";
 var CAB_API = "http://54.179.118.36/Airdely/getprice?";
//var CAB_API = "http://18.139.7.190/smart_gateway_get";
//var CAB_API = "http://151.192.64.6:5001/smart_gateway_get";
var CAB_KEY = "45998b9e-3193-455c-94bd-93453ab80bc5";




// Messages




//NETWORK
var NETWORK_CONNECTED = "You are online now!";
var NETWORK_DISCONNECTED = "Your network disconnected.";
var CHECK_NETWORK = "Please check your network connection.";
var SOMETHING_WRONG = "Something went wrong. Please try again.";


//API HTTP ERROR
var MOVED_PERMANENT = "301 Moved Permanently.";
var BAD_REQUEST = "400 Bad Request.";
var UNAUTHORIZED = "401 Unauthorized.";
var NOT_FOUND = "404 Not Found.";
var SERVER_ERROR = "500 Internal Server Error.";


//FORM VALIDATION
var MOBILE_NUMBER_REQUIRED = "Please enter the mobile number";
var NAME_REQUIRED = "Please enter the name";
var PASSWORD_REQUIRED = "Please enter the password";
var OTP_REQUIRED = "Please enter the OTP";
var PASSWORD_MINLENGTH = "Password length should be min. 8 chars";
var PASSWORD_NOTMATCH = "Password doesn\"t match";
var NAME_MINLENGTH = "Name should contain min. 1 char";
var MOBILE_INVALID = "Invalid Mobile number";
var EMAIL_REQUIRED = "Please enter the email";
var EMAIL_INVALID = "Please enter the valid email";
var OTP_INVALID = "Entered OTP is incorrect.";
var PICKUP_INVALID = "Please enter the pickup location";
var DROP_INVALID = "Please enter the drop location";
var MOBILE_DISABLE = "Mobile number can\"t be change.";
var ADDRESS_REQUIRED = "Please enter the address";
var LOCATION_REQUIRED = "Please enter the location name";


//LOADER
var LOADER_WAIT = "Please wait...";
var LOADER_VALIDATE = "Validating user...";
var LOADER_VERIFY = "Verifying OTP...";
var FETCH_LOCATION = "Fetching your location...";
var SEARCH_CABS = "Searching cabs...";


//GPS
var COORD_ERROR = "Error getting location coordinates";
var LOCATION_ERROR = "Error requesting location permissions";
var ADDRESS_ERROR = "Error while parsing address";
var GEOCODER_ERROR = "Geocoder failed due to: ";
var GOOGLE_PLACE_ERROR = "No results found";
var DIRECTION_ERROR = "Directions request failed due to ";


//SMS
var SMS_BODY = "is your verification code for the CarHailer app.";
var SMS_SUCCESS = "OTP sent successfully!";


//ALERT
var LOGOUT_CONFIRM = "Are you sure to logout from the app?";
var EXIT_CONFIRM = "Are you sure to exit from the app?";
var LOCATION_CONFIRM = "We have failed to fetch your current location. Please enable it to continue with the app.";
var BACK_CONFIRM = "Are you sure to go back?";
var DELETE_CONFIRM = "Are you sure to delete this location?";
var SAVE_CONFIRM = "You have unsaved changes. If you go back, changes will be discarded.";
var ALERT_SUCCESS = "Success";
var ALERT_SORRY = "Sorry";
var ALERT_CONGRATS = "Congratulations";
var REDEEM_ADDRESS_PROMPT = "Please enter your address to continue";
var LOGIN_ATTEMPT_TITLE = "Password Expired";
var LOGIN_ATTEMPT_MSG = "Please set the new password to continue";
var NO_DATA_FOUND = "No results found.";
var NO_SERVICE = "Service not available right now.";
var NO_CORDOVA_TITLE = "Cordova Not Supported";
var NO_CORDOVA_SUBTITLE = "You have running app on non-cordova Platform";
var NO_CORDOVA_MSG = "Some features will not work properly";
var AD_MSG = "";


var IS_VALID = "is_valid"
var strDATA = "Data"
var strMessage = "Message"
var strStatus = "Status"
var strmessage = "message"



// API Contacts

var URL_RedeemHistory = BASEURL + "/redeem_history/+6592232843"
var URL_GetTripHistory = BASEURL + "/trip_history/" + appDelegate.mobileNumner
var URL_RedeemPoints = BASEURL + "/insert_redeemed_user/"
var URL_AddTripHistory = BASEURL + "/insert_trip_history/"
var URL_AddFavLocation = BASEURL + "/add_location/"
var URL_FavLocations = BASEURL + "/favourite_location/"  + appDelegate.mobileNumner
var URL_DeleteLocation = BASEURL + "/delete_location/"
var URL_FAQ = BASEURL + "/faq"
var URL_PrivacyPolicy = BASEURL + "/privacy_policy"
var URL_TC = BASEURL + "/terms_condition"
var URL_CU = BASEURL + "/settings"
var URL_EO = BASEURL + "/earning_opportunities"
var URL_UL = BASEURL + "/update_location/" 
var URL_BLastAd = BASEURL +  "/blast_advertisement"
var URL_AdvertVideo = BASEURL + "/advertisement_video"
var URL_UpdateToken = BASEURL + "/update_usertoken/"
var URL_NotificationList = BASEURL + "/notification_list/"
var URL_DeleteNotification = BASEURL + "/delete_notification/"
var URL_UpdateLastLogin = BASEURL + "/update_userlastlogin/"
var URL_NotificationDetails = BASEURL + "/notification_detail/"
var URL_Login = BASEURL + "/login/"
var URL_SignUp = BASEURL + "/signup/"
var URL_IsUserExist = BASEURL + "/user_exists/"
var URL_SendSms = BASEURL + "/send_sms/"
var URL_AdvertiseMent = BASEURL + "/advertisement"
var URL_GetProfile = BASEURL + "/get_profile/"  + appDelegate.mobileNumner
var URL_UpdatePassword = BASEURL + "/update_password/"
var URL_UpadateProfile = BASEURL + "/update_profile/" + appDelegate.mobileNumner
var URL_AddRewards = BASEURL + "/insert_reward_history/"
var URL_RewardHistory = BASEURL + "/reward_history/" + appDelegate.mobileNumner
var URL_RedeemOffer = BASEURL + "/redeem/"


 struct APIUrls {
    static let HOST_URL = "https://CarHailerbudget.in/"
    static let BASE_PATH = "webservices/api.php?action="
    static let LOGIN_URL = HOST_URL + BASE_PATH + "authentication"
    static let SLIDER_IMGS_URL = HOST_URL + BASE_PATH + "get_slider"
    static let GET_OFFERS_URL = HOST_URL + BASE_PATH + "get_offers"
    static let CATEGORIES_DATA_URL = HOST_URL + BASE_PATH + "get_categories"
    static let SUB_CATEGORIES_DATA_URL = HOST_URL + BASE_PATH + "get_subcategories&uuid="
    static let PRODUCT_BY_CATEGORY_DATA_URL = HOST_URL + BASE_PATH + "get_products_by_category&id="
    static let REGISTRATION_URL = HOST_URL + BASE_PATH + "registration"
    static let GET_PINCODE_URL = HOST_URL + BASE_PATH + "get_pincode"
    static let VERIFY_OTP = HOST_URL + BASE_PATH + "verify_otp"
    static let GET_REFERRAL = HOST_URL + BASE_PATH + "get_referral"
    static let GET_WALLET = HOST_URL + BASE_PATH + "get_wallet"
    static let ADD_ORDER_URL = HOST_URL + BASE_PATH + "add_order"
    static let WALLET_HISTORY_URL = HOST_URL + BASE_PATH + "get_wallet_history"
    static let ORDER_HISTORY_URL = HOST_URL + BASE_PATH + "get_order_history"
    static let ORDER_DETAILS_URL = HOST_URL + BASE_PATH + "get_order_history"
    static let WALLET_DEDUCT_URL = HOST_URL + BASE_PATH + "wallet_deduct"
}


typealias JSONDictionary = [String : Any]

func asString(jsonDictionary: JSONDictionary) -> String {
  do {
    let data = try JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
    return String(data: data, encoding: String.Encoding.utf8) ?? ""
  } catch {
    return ""
  }
}



struct APISuccessResponse {
    static let RESPONSE_CODE:String = "2XX"
    static let Message:String = "Success"
}





extension UIStoryboard {
    class func load(_ storyboard: String) -> UIViewController{
          return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: storyboard)
}
}



class Constant {
    
    var IS_USER_LOGIN = "is_user_login"
    var ACCESS_TOKEN = "access_token"
    var USER_DATA = "user_data"
    var USER_ID = "user_id"
    var IS_SHOW_ONCE = "IS_SHOW_ONCE"
}
var constant = Constant()


func safeString(data : Any) -> String {
    
    var str : String = ""
    if(data is NSNull)
    {
        str = ""
    } else if(data is NSNumber)
    {
        str = ""
    }  else {
        str = (data as? String)!
    }
    return str
}




final class ContentSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        if(self.isHidden){
              return CGSize(width: UIView.noIntrinsicMetric, height: 0)
        }
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}



enum SideMenuItems: String {
    case Home = "Home"
    case MyProfile = "My Profile"
    case FP = "Favourite Places"
    case RM =  "Redeem History"
    case EO = "Earning Opportunities"
    case VA = "View Advertisement"
    case Logout = "Log Out"
    case TC = "Terms & Conditions"
    case PrivacyPolicy = "Privacy & Policy"
    case ContactUs = "Contact Us"
    case FAQ = "Help & FAQs"
}


enum StoryBoardName: String {
    case Auth = "Auth"
    case Sidemenu = "SidemenuVC"
       case customTabbar = "CustomTabbar"
}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}

enum VCName: String {
    case Login = "LoginVC"
    case ForgotPassword = "ForgotPasswordVC"
    case NewPassword = "NewPasswordVC"
    case Signup = "SignupVC"
    case OtpVc = "OTPVC"
    case Sidemenu = "SidemenuVC"
    case Home = "HomeVC"
    case MyProfile = "MyProfileVC"
    case MyOrders = "MyOrdersVC"
    case MyAddress = "MyAddressVC"
    case Feedback =  "FeedbackVC"
    case Contact = "ContactVC"
    case Share = "Share"
    case Logout = "Logout"
    case About = "AboutVC"
    case PrivacyPolicy = "PrivacyPolicyVC"
    case SubCategories = "SubCategoriesVC"
    case ProductList = "ProductListVC"
    case MyCart = "MyCartVC"
    case DeliveryDetails = "DDVC"
    case PaymentVC = "PaymentVC"
    case ThankYouVC = "ThankYouVC"
    case WalletHistoryVC = "WalletHistoryVC"
    case OrderDetailsVC = "OrderDetailsVC"
    
}


extension UIStoryboard {
//    class func load(_ storyboard: StoryBoardName) -> UIViewController{
//          return UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: storyboard.rawValue)
//}
    
     class func loadFromAuth(_ vc: VCName) -> UIViewController{
              return UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: vc.rawValue)
    }
    
    class func loadFromSideMenu(_ vc: String) -> UIViewController{
                 return UIStoryboard(name: "SidemenuVC", bundle: nil).instantiateViewController(withIdentifier: vc)
       }
    
    class func loadFromTabs(_ vc: String) -> UIViewController{
                  return UIStoryboard(name: "CustomTabbar", bundle: nil).instantiateViewController(withIdentifier: vc)
        }
    
    class func loadFromOther(_ vc: String) -> UIViewController{
                     return UIStoryboard(name: "Other", bundle: nil).instantiateViewController(withIdentifier: vc)
           }
}


enum Colors :String {
    case primaryColor = "#f5f5f5"
    case barColor = "#f5570e"
}


extension String {

func isValidString() -> Bool {
    let newStr = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    if newStr.count == 0 {
        return false
    }
    return true
}

func isValidEmail() -> Bool {
    let emailRegEx = "(?:[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?|\\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[A-Za-z0-9-]*[A-Za-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    
    return emailTest.evaluate(with: self)
}

func isValidUserName() -> Bool {
    let uesrNameRegEx = "^[0-9a-zA-Z\\_.]{3,18}$"
    let userNameTest = NSPredicate(format:"SELF MATCHES %@", uesrNameRegEx)
    return userNameTest.evaluate(with: self)
}

func isValidPassword() -> Bool {
    if self.count < 6 {
        return false
    }
    return true
}
    
func isValidPinCode() -> Bool {
        if self.count != 6 {
            return false
        }
        return true
    }
 

func isValidMobile() -> Bool {
    let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
    let inputString = self.components(separatedBy: charcterSet)
    let filtered = inputString.joined(separator: "")
    
    if self.count >= 8 && self == filtered {
        return true
    }
    return false
}
}

func displayToast(_ message : String)
{
    var style = ToastStyle()
    style.backgroundColor = UIColor.black
    style.messageColor = .white
    mainWindow!.makeToast(message, duration: 1.5, position: .bottom, title: nil, image: nil, style: style, completion: nil)
    //Constants.mainWindow!.makeToast(message)
}

func displaySuccessToast(_ message : String)
{
    var style = ToastStyle()
    style.backgroundColor = UIColor.green
    style.messageColor = .white
    mainWindow!.makeToast(message, duration: 1.5, position: .top, title: "", image: nil, style: style, completion: nil)
    //Constants.mainWindow!.makeToast(message)
}
func displayDefaultToast(_ message : String)
{
    var style = ToastStyle()
    style.backgroundColor = UIColor.black
    style.messageColor = .white
    mainWindow!.makeToast(message, duration: 1.5, position: .top, title: "", image: nil, style: style, completion: nil)
    //Constants.mainWindow!.makeToast(message)
}


class InsetLabel: UILabel {

    var contentInsets = UIEdgeInsets.zero

    override func drawText(in rect: CGRect) {
        let insetRect = rect.inset(by: contentInsets)
        super.drawText(in: insetRect)
    }

    override var intrinsicContentSize: CGSize {
        return addInsets(to: super.intrinsicContentSize)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return addInsets(to: super.sizeThatFits(size))
    }

    private func addInsets(to size: CGSize) -> CGSize {
        let width = size.width + contentInsets.left + contentInsets.right
        let height = size.height + contentInsets.top + contentInsets.bottom
        return CGSize(width: width, height: height)
    }

}



func csv(data: String) -> [String] {
    let rows = data.components(separatedBy: "@")
//    for row in rows {
//        let columns = row.components(separatedBy: "$")
//        result.append(columns)
//    }
    return rows
}

func itemcsv(data: String) -> [String] {
    let rows = data.components(separatedBy: "$")
//    for row in rows {
//        let columns = row.components(separatedBy: "$")
//        result.append(columns)
//    }
    return rows
}


extension UIImageView {
    func loadFromURL(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


