//
//  SidemenuCell.swift
//  The RKC
//
//  Created by Munjiyasara Nikunj on 18/05/20.
//  Copyright © 2020 Nikunj Munjiyasara. All rights reserved.
//

import UIKit

class SidemenuCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var imgView : UIImageView!

    override func awakeFromNib(){
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
