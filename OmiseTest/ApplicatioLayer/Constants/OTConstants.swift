//
//  OTConstants.swift
//  OmiseTest
//
//  Created by Dhananjay on 09/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import UIKit

class OTConstants: NSObject {

    //application constants
    static let kApplicationName         =   "OmiseTest"
    static let SCREEN_SIZE: CGRect       =   UIScreen.main.bounds
    
    static let kTest_HostName       =       "www.google.com"
    static let kWsDefaultBaseUrl        =   "https://virtserver.swaggerhub.com/chakritw/tamboon-api/1.0.0"
    static let kWsCharitiesList         =   kWsDefaultBaseUrl + "/charities"
    static let kWsMakeDonation          =   kWsDefaultBaseUrl + "/donations"
    
    //Alert Messages
    static let alertForAPIFailure       =   "Something is wrong with server, Please try again later."
    static let KAlertNoInternetConnection    =  "No Internet Connection."
    static let KAlertEnterValidAmount   =   "Please enter donation amount."
    //AlertTitle Constants
    static let kAlertTypeOK             =   "Ok"
    static let kAlertTypeCancel         =   "Cancel"
    static let kAlertTypeYES            =   "Yes"
    static let kAlertTypeNO             =   "No"
    static let kAlertHideCancel         =   ""

}

extension UIColor {
    static let appThemeColor = UIColor(red: 0/255, green: 173/255, blue: 177/255, alpha: 1.0)
}
