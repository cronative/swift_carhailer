//
//  PrivacyPolicyCell.swift
//  CarHailer
//
//  Created by Nikunj on 06/12/20.
//  Copyright © 2020 Nikunj M. All rights reserved.
//

import UIKit

class PrivacyPolicyCell: UITableViewCell {
 @IBOutlet weak var lblTitle : UILabel!
     @IBOutlet weak var lblDescription : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showDataInCell(objDic:[String:Any]){
        
        self.lblTitle.text = objDic["title"] as? String

          let s = objDic["title"] as? String
        
        
        if(s == "How do I get CARHAILER on my phone?"){
        
                   self.lblDescription.text = "CARHAILER is available on Apple app store."
               } else {
                   let replaced = (objDic["description"] as? String)!.replacingOccurrences(of: "Android", with: "")
                   self.lblDescription.text = replaced
               }
        
//        self.lblDescription.text = replaced
//        let myNormalAttributedTitle = NSAttributedString(string: (objDic["description"] as? String)!,
//        attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
//        self.lblDescription.attributedText = myNormalAttributedTitle


   
    }
    
    func showTCdata(){
     
    }

    func showData(objDic:[String:Any], ind : String){
        let s = objDic["title"] as? String
        if(s == "How do I get CARHAILER on my phone?"){
            let replaced = (objDic["description"] as? String)!.replacingOccurrences(of: "Android", with: "")
            self.lblDescription.text = "CARHAILER is available on Apple app store."
        } else {
            let replaced = (objDic["description"] as? String)!.replacingOccurrences(of: "Android", with: "")
            self.lblDescription.text = replaced
        }
        self.lblTitle.text = (ind + "." + s!)
        
       }
}


extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
