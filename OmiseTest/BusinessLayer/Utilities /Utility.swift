//
//  Utility.swift
//  OmiseTest
//
//  Created by Dhananjay on 09/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//
import UIKit

class Utility: NSObject {

    class var sharedInstance: Utility
    {
        //creating Shared Instance
        struct Static
        {
            static let instance: Utility = Utility()
        }
        return Static.instance
    }
    
    /// function returns the main stroyboard object
    static func getMainStroryBoard() -> UIStoryboard{
      let stroyboard = UIStoryboard(name: "Main", bundle: nil)
        return stroyboard
    }
    
    class func setCasaTourNavigationBarForView(_ vc: UIViewController) {
        vc.navigationItem.hidesBackButton = false
        vc.navigationController?.navigationBar.isTranslucent = false
        let appIconImage = UIImageView.init(image: UIImage.init(named: "omise_logo"))
        let marginX = (vc.navigationController!.navigationBar.frame.size.width / 2) - (150 / 2)
        appIconImage.frame = CGRect.init(x: marginX, y: 5, width: 150, height: 30)
        appIconImage.contentMode = .scaleAspectFit
        vc.navigationController?.navigationBar.addSubview(appIconImage)
        
        vc.navigationController?.navigationBar.barStyle = .default
        if let statusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            statusbarView.backgroundColor = .white
        }
    }
    
}
