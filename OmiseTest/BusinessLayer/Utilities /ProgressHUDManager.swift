//
//  ProgressHUDManager.swift
//  DJUtilities
//
//  Created by Dhananjay on 08/10/2019.
//  Copyright © 2019 Dhananjay Pawar. All rights reserved.
//

import UIKit

class ProgressHUDManager: NSObject {

    //shared instance
    static let sharedInstance = ProgressHUDManager()
    private override init() {
        super.init()
    }

    static func showProgress (visibility show : Bool){
        DispatchQueue.main.async(execute: {
            if show {
                let loaderGif = UIImage.gifImageWithName("app_loader")
                let imageView = UIImageView(image: loaderGif)
                imageView.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0)
                //ZVProgressHUD.displayStyle = .custom(backgroundColor: .clear, foregroundColor: .clear)
                ZVProgressHUD.show(with: .custom(view: imageView))
            } else{
                ZVProgressHUD.dismiss()
            }
        });
    }

}
