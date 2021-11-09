//
//  CustomTabbar.swift
//  The RKC
//
//  Created by Munjiyasara Nikunj on 17/05/20.
//  Copyright © 2020 Nikunj Munjiyasara. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController



class CustomTabbar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
   
    
    
    override func viewWillAppear(_ animated: Bool) {
           navigationController?.isNavigationBarHidden = true
           super.viewWillAppear(animated)
       }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
                  super.viewWillDisappear(animated)
    }
    func pushToView() {
        print("pushToView")
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



class MainTabBar: UITabBar {

    override func layoutSubviews() {
        super.layoutSubviews()

        // iOS 11: puts the titles to the right of image for horizontal size class regular. Only want offset when compact.
        // iOS 9 & 10: always puts titles under the image. Always want offset.
        var verticalOffset: CGFloat = 5.0

        if #available(iOS 11.0, *), traitCollection.horizontalSizeClass == .regular {
            verticalOffset = 0.0
        }
        self.tintColor = hexStringToUIColor(hex: "#F5570E")
        
        let imageInset = UIEdgeInsets(
            top: verticalOffset,
            left: 0.0,
            bottom: -verticalOffset,
            right: 0.0
        )

        for tabBarItem in items ?? [] {
            tabBarItem.title = ""
            tabBarItem.imageInsets = imageInset
        }
    }
}
