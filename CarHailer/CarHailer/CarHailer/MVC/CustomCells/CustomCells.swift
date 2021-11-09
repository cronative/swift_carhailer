//
//  CustomCells.swift
//  CarHailer
//
//  Created by Nikunj on 06/12/20.
//  Copyright © 2020 Nikunj M. All rights reserved.
//

import UIKit
import SDWebImage
import SDWebImageWebPCoder

class CustomCells: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class AdvertisementCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblDescription : UILabel!
    @IBOutlet weak var lblPoints : UILabel!
    @IBOutlet weak var lblDate : UILabel!
    
    @IBOutlet weak var imgView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func showData(objDic : [String : Any]){
        self.lblDate.text = GetDateByFormat(date: (objDic["created_on"] as? String)!, format: "MMM dd, yyyy") as String
        self.lblTitle.text = objDic["name"] as? String
        self.lblDescription.text = objDic["description"] as? String
        self.lblPoints.text = objDic["points"] as? String
        self.imgView?.sd_setImage(with: URL(string: (objDic["video_thumbnail_url"] as? String)!), completed: nil)
        
    }
    
}


class CountryCodeCell: UITableViewCell {
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblCode : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func showDataInCell(objDic : [String : Any]){
        self.lblTitle.text = "(\((objDic["dial_code"] as? String)!)) \((objDic["name"] as? String)!)"
        self.lblCode.text = objDic["code"] as? String
    }
    
}

protocol RewardCellDelegate {
    func onClickRedeem()
    func onClickRedeemHistory()
}

class RedeemCell: UITableViewCell {
    @IBOutlet weak var lblAP : UILabel!
    @IBOutlet weak var lblTRP : UILabel!
    @IBOutlet weak var lblRP : UILabel!
    
    @IBOutlet weak var lblRH : UILabel!
    
    var delegate: RewardCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func onClickRedeem(sender:UIButton){
        self.delegate.onClickRedeem()
    }
    
    
     @IBAction func onClickRedeemHistory(sender:UIButton){
         self.delegate.onClickRedeemHistory()
     }
    
}

class RedeemHistoryCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblDescription : UILabel!
    @IBOutlet weak var lblPoints : UILabel!
    @IBOutlet weak var lblDate : UILabel!
    
    @IBOutlet weak var imgView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func showData(objDic : [String : Any]){
        self.lblDate.text = GetDateByFormat(date: (objDic["created_on"] as? String)!, format: "MMM dd, yyyy") as String
        self.lblTitle.text = objDic["reward_name"] as? String
        
        self.lblPoints.text = objDic["reward_points"] as? String
        guard let webpURL = URL(string: (objDic["file_url"] as? String)!)  else {
            self.imgView?.image = UIImage.init(named: "car_placeholder.png")
            return}
        DispatchQueue.main.async {
            self.imgView?.sd_setImage(with: webpURL)
        }
        
    }
}


class NotificaitonCell: UITableViewCell {
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblDate : UILabel!
    @IBOutlet weak var lblDiscription : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func showData(objDic : [String : Any]){
        self.lblDate.text = GetDateByFormat(date: (objDic["created_on"] as? String)!, format: "MMM dd, yyyy") as String
        self.lblTitle.text = objDic["title"] as? String
        self.lblDiscription.text = objDic["message"] as? String
        
    }
    
    
}

protocol FavPlaceDelegate {
    func onClickDelete(sender:UIButton)
    func onClickEdit(sender: UIButton)
}

class FavPlaceCell: UITableViewCell {
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblPlace : UILabel!
    
    @IBOutlet weak var btnEdit : UIButton!
    @IBOutlet weak var btnDelete : UIButton!
    //    @IBOutlet weak var lblDiscription : UILabel!
    
    var delegate : FavPlaceDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func showData(objDic : [String : Any]){
        //              self.lblDate.text = GetDateByFormat(date: (objDic["created_on"] as? String)!, format: "MMM dd, yyyy") as String
        self.lblName.text = objDic["name"] as? String
        self.lblPlace.text = objDic["location_address"] as? String
        
    }
    
    @IBAction func onClickBtnDelete(sender: UIButton){
        self.delegate.onClickDelete(sender: sender)
    }
    @IBAction func onClickBtnEdit(sender: UIButton){
        self.delegate.onClickEdit(sender: sender)
    }
    
    
}




class TripResultCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblClass : UILabel!
    @IBOutlet weak var lblPrice : UILabel!
    @IBOutlet weak var lblWT : UILabel!
    
    @IBOutlet weak var imgView : UIImageView!
    
    @IBOutlet weak var triangleView: UIView!
    @IBOutlet weak var cellContent: UIView!
    @IBOutlet weak var lblTyppe: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setUpTriangle()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setUpTriangle(){
     let heightWidth = triangleView.frame.size.width
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: heightWidth))
        path.addLine(to: CGPoint(x:heightWidth/2, y: 0))
        path.addLine(to: CGPoint(x:heightWidth, y:heightWidth))
        path.addLine(to: CGPoint(x:0, y:heightWidth))
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = hexStringToUIColor(hex: "#DB4A39").cgColor

        triangleView.layer.insertSublayer(shape, at: 0)
    }
    
    
    func showData(objDic: [String: Any]){
        self.lblTitle.text = safeString(data: objDic["Type"]!)
        self.lblClass.text = safeString(data: objDic["Class"]!)
        
        self.lblWT.text = safeString(data: objDic["WaitingTime"]!)
        
        
        if(safeString(data: objDic["Price"]!) != ""){
            self.lblPrice.text = "$" +  safeString(data: objDic["Price"]!)
            self.lblPrice.textColor = UIColor.systemGreen
            self.lblPrice.font = UIFont.systemFont(ofSize: 14)
        } else {
            self.lblPrice.text = "Price Unavailalbe"
            self.lblPrice.font = UIFont.systemFont(ofSize: 10)
            self.lblPrice.textColor = UIColor.gray
            
            if (safeString(data: objDic["APIError"]!) != ""){
                self.lblPrice.text = safeString(data: objDic["APIError"]!)
            } else {
                self.lblPrice.text = "Price Unavailalbe"
            }
        }
        
        
        guard let webpURL = URL(string: (objDic["Logo_url"] as? String)!)  else {
            self.imgView?.image = UIImage.init(named: "car_placeholder.png")
            return
        }
     
        if(safeString(data: objDic["Class"]!) == "Gojek"){
        self.imgView?.image = UIImage.init(named: "gojek.jpg")
        } else {
            DispatchQueue.main.async {
                     self.imgView?.sd_setImage(with: webpURL)
                 }
        }
        
        /*
         if(safeString(data: objDic["Type"]!) == "ComfortDelgro"){
         self.imgView?.image = UIImage.init(named: "comfortdelgro.jpg")
         } else   if(safeString(data: objDic["Type"]!) == "FastGo"){
         self.imgView?.image = UIImage.init(named: "fastgo.jpg")
         } else if(safeString(data: objDic["Type"]!) == "Gojek"){
         self.imgView?.image = UIImage.init(named: "gojek.jpg")
         } else   if(safeString(data: objDic["Type"]!) == "Tada"){
         self.imgView?.image = UIImage.init(named: "tada.jpg")
         }else   if(safeString(data: objDic["Type"]!) == "Grab"){
         self.imgView?.image = UIImage.init(named: "grab.jpg")
         } else {
         //            self.imgView?.image = UIImage.init(named: "car_placeholder.png")
         guard let webpURL = URL(string: (objDic["image_url"] as? String)!)  else {return}
         DispatchQueue.main.async {
         self.imgView?.sd_setImage(with: webpURL)
         }
         }
         
         
         */
        
        
        //        self.imgView?.sd_setImage(with: URL(string: (objDic["Logo_url"] as? String)!), completed: nil)
    }
    
}


class TripHistoryCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblDescription : UILabel!
    @IBOutlet weak var lblPoints : UILabel!
    @IBOutlet weak var lblDate : UILabel!
    @IBOutlet weak var lblPickUpLocation : UILabel!
    @IBOutlet weak var lblDropLocation : UILabel!
    
    @IBOutlet weak var imgView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func showData(objDic : [String : Any]){
        self.lblDate.text = GetDateByFormat(date: (objDic["trip_date"] as? String)!, format: "MMM dd, yyyy h:mm a") as String
        self.lblTitle.text = objDic["service_name"] as? String
        self.lblDescription.text = "Duration: " + (objDic["duration"] as? String)!
        if(safeString(data: objDic["trip_amount"]!) != ""){
            self.lblPoints.text = "$" + safeString(data: objDic["trip_amount"]!)
        } else {
            self.lblPoints.text = "$0"
        }
        
        self.lblPickUpLocation.text = safeString(data: objDic["from_location"]!)
        self.lblDropLocation.text = safeString(data: objDic["to_location"]!)
        
        guard let webpURL = URL(string: (objDic["image_url"] as? String)!)  else {
            self.imgView?.image = UIImage.init(named: "car_placeholder.png")
            return
            
        }
        if(safeString(data: objDic["service_name"]!) == "Gojek"){
            self.imgView?.image = UIImage.init(named: "gojek.jpg")
        } else {
            DispatchQueue.main.async {
                self.imgView?.sd_setImage(with: webpURL)
            }
        }
              
        
    }
    
}

class RedeemOfferCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblDescription : UILabel!
    @IBOutlet weak var lblPoints : UILabel!
    @IBOutlet weak var lblDate : UILabel!
    
    @IBOutlet weak var imgView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func showData(objDic : [String : Any]){
        //self.lblDate.text = GetDateByFormat(date: (objDic["created_on"] as? String)!, format: "MMM dd, yyyy") as String
        self.lblTitle.text = objDic["redeem_name"] as? String
        self.lblDescription.text = objDic["description"] as? String
        self.lblPoints.text = objDic["points"] as? String
        self.imgView?.sd_setImage(with: URL(string: (objDic["file_url"] as? String)!), completed: nil)
        
    }
    
}
