//
//  AdDetailsVC.swift
//  CarHailer
//
//  Created by Nikunj on 06/12/20.
//  Copyright © 2020 Nikunj M. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class AdDetailsVC: UIViewController {

    var objDic = [String: Any]()
    var player1 = AVPlayer()
    
    @IBOutlet weak var lblTitle : UILabel!
      @IBOutlet weak var lblDescription : UILabel!
      @IBOutlet weak var lblPoints : UILabel!
      @IBOutlet weak var viewVideo : UIView!
      
      @IBOutlet weak var imgView : UIImageView!
    
    var img_or_video : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("objDic >> ", objDic)
        
        // Do any additional setup after loading the view.
        self.lblTitle.text = (self.objDic["name"] as? String)!
        self.lblDescription.text = (self.objDic["description"] as? String)!
        self.lblPoints.text =   "Earning Points: \((self.objDic["points"] as? String)!) /(30 sec)"
        
        
        if(img_or_video == "img"){
            self.viewVideo.isHidden = true
            self.imgView.isHidden = false
            self.imgView?.sd_setImage(with: URL(string: (objDic["file_url"] as? String)!), completed: nil)
        } else{
            self.playVideo(url: URL(string: (self.objDic["file_url"] as? String)!)!)
            self.viewVideo.isHidden = false
            self.imgView.isHidden = true
        }
        
        
    }
    
    func playVideo(url: URL) {
        
        self.player1 = AVPlayer(url: url)
        let playerLayer1 = AVPlayerLayer(player: self.player1)
        playerLayer1.frame = self.viewVideo.bounds
        self.viewVideo.layer.addSublayer(playerLayer1)
        
        
        let player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.viewVideo.bounds
//        self.viewVideo.layer.addSublayer(playerLayer)
        
        
      
        let duration = CMTimeGetSeconds((self.player1.currentItem?.asset.duration)!)

        let d = self.player1.currentItem?.duration
        print(d,duration)

        self.player1.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main, using: { (time) in
            if player.currentItem?.status == .readyToPlay {
                let currentTime = CMTimeGetSeconds(self.player1.currentTime())

                let secs = Int(currentTime)
               print(secs)
                
                if(secs == 20){
                    self.postDataFromServer()
                }

            }})
        
        self.player1.play()
    }
    
    @IBAction func onClickClose(sender: UIButton){
        if(img_or_video == "img"){
            self.dismiss(animated: true, completion: nil)
            return
        }
         let currentTime = CMTimeGetSeconds(self.player1.currentTime())
         let duration = CMTimeGetSeconds((self.player1.currentItem?.asset.duration)!)
        if(currentTime < 20  && duration > 20){
            self.showAlert()
            self.player1.pause()
        } else {
             self.player1.stop()
             self.dismiss(animated: true, completion: nil)
        }
        
//        self.player1.stop()
        
       
    }
    
    func showAlert(){
        
         let currentTime = CMTimeGetSeconds(self.player1.currentTime())
        let secs = Int(currentTime)
         let s = 20 - secs
        
        let refreshAlert = UIAlertController(title: "CarHailer", message: " To get reward points, watch video for " + "\(s)" + " seconds more.", preferredStyle: UIAlertController.Style.alert)

                       refreshAlert.addAction(UIAlertAction(title: "Stop", style: .cancel, handler: { (action: UIAlertAction!) in
                             print("Handle Ok logic here")
                        self.player1.stop()
                        self.dismiss(animated: true, completion: nil)
                       }))

                       refreshAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action: UIAlertAction!) in
                             print("Handle Cancel Logic here")
                           self.player1.play()
                       }))

                       present(refreshAlert, animated: true, completion: nil)
    }
    

    @IBAction func onClickClickHere(sender: UIButton){
        self.openLink(strUrl: safeString(data: objDic["url"]!))
        self.dismiss(animated: true, completion: nil)
//        self.postDataFromServer()
//           self.dismiss(animated: true, completion: nil)
       }
    func postDataFromServer(){
            
        let params : Parameters = ["mobile":appDelegate.mobileNumner!,"reward_name":safeString(data: objDic["name"]!) ,"reward_points":safeString(data: objDic["points"]!),"reward_date":"" , "file_url":self.img_or_video == "img" ? safeString(data: objDic["file_url"]!) : safeString(data: objDic["video_thumbnail_url"]!),"rewards_from":"Advertisement"]
            
        
            callWebservice1(URL: URL_AddRewards, httpMethod: .post, Params:params, completion: { ( response : [String: Any]) in
                print("API response => ",response)
                let a : NSArray = response["Message"] as! NSArray
                if(a.count>0){
                    let b :[String: Any] = a[0] as! [String : Any]
                    displayToast(b["message"] as! String)
                }
//
                
    //              if(a.count > 0){
    //                  self.objData = a[0] as! NSArray
    //              }
    //              self.objData = self.objData.reversed() as NSArray
    //              self.tblView.reloadData()
              }) { (error) in
                  print(error.localizedDescription)
              }
              
          }
    
    func openLink(strUrl: String){
        guard let url = URL(string: strUrl) else { return }
        UIApplication.shared.open(url)
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


extension AVPlayer {
   func stop(){
    self.seek(to: CMTime.zero)
    self.pause()
   }
}
