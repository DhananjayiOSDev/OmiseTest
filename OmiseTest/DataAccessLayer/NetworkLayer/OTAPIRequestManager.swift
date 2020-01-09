//
//  OTAPIRequestManager.swift
//  OmiseTest
//
//  Created by Dhananjay on 09/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import UIKit
import Alamofire
import SystemConfiguration

class OTAPIRequestManager: NSObject {
    
    //mark: -static declaration
    enum kMethodType : Int {
        case kTypeGET = 0
        case kTypePOST
        case kTypeFORM_POST
    }
    
    static let sharedInstance = OTAPIRequestManager()

    typealias OnSuccessCompletionHandler = (_ receivedString: Any) -> Void
    typealias OnProgressCompletionHandler = (_ receivedString: Progress) -> Void
    typealias OnFailureCompletionHandler = (_ error: Error?) -> Void

    
    static func callAPI(KMethodType method:kMethodType ,APIName strAPI: String,Parameters parameters:
        Parameters? = nil,HttpHeaders headers:HTTPHeaders? = nil,isProgressBar:Bool? = true, onSuccess success: @escaping OnSuccessCompletionHandler, onFailure failure:
        @escaping OnFailureCompletionHandler) {

        if Network.reachability.isConnectedToNetwork {

            let strAbsoluteURL: String = "\(strAPI)".trimmingCharacters(in: .whitespaces)

            var requestMethod : HTTPMethod

            switch method {
            case .kTypeGET:
                requestMethod = .get

            case .kTypePOST:
                requestMethod = .post

            case .kTypeFORM_POST:
                requestMethod = .post
            }

            print("\(NSDate()) Request : \(strAbsoluteURL)\nParameters: \n \(String(describing: parameters))")
            if isProgressBar!{
                ProgressHUDManager.showProgress(visibility: true)
            }
            if method == .kTypeFORM_POST{
                Alamofire.upload(
                    multipartFormData: { multipartFormData in
                        for strRecord in parameters! {
                            if FileManager.default.fileExists(atPath: strRecord.value as! String) {
                                let url: String? = strRecord.value as? String
                                let parts: [Any]? = url?.components(separatedBy: "/")
                                let filename: String? = parts?.last as? String
                                if ((filename?.range(of: ".jpg")?.lowerBound) != nil) {

                                    multipartFormData.append(FileManager.default.contents(atPath:
                                        strRecord.value as! String)!, withName: strRecord.key, fileName:
                                        "\(filename ?? "" )", mimeType: "image/jpeg")
                                }else if ((filename?.range(of: ".pdf")?.lowerBound) != nil) {

                                    multipartFormData.append(FileManager.default.contents(atPath:
                                        strRecord.value as! String)!, withName: strRecord.key, fileName:
                                        "\(filename ?? "" )", mimeType: "application/pdf")
                                }
                            }
                            else {
                                multipartFormData.append((strRecord.value as AnyObject).data(using:
                                    String.Encoding.utf8.rawValue)!, withName: strRecord.key)
                            }
                        }
                },
                    to: strAbsoluteURL,
                    encodingCompletion: { encodingResult in

                        switch encodingResult {
                        case .success(let upload, _, _):
                            upload.validate(statusCode: 200..<201)
                            upload.responseJSON { response in
                                switch response.result {
                                case .success:
                                    if isProgressBar! {
                                        ProgressHUDManager.showProgress(visibility: false)
                                    }
                                    success(response.result.value!)
                                case .failure(let error):
                                    print(error)

                                    if isProgressBar! {
                                        ProgressHUDManager.showProgress(visibility: false)
                                    }
                                    failure(error)
                                }
                            }
                        case .failure(let encodingError):
                            if isProgressBar! {
                                ProgressHUDManager.showProgress(visibility: false)
                            }
                            failure(encodingError)
                        }
                }
                )

            } else{
                Alamofire.request(strAbsoluteURL, method: requestMethod, parameters: parameters,headers: headers)
                    .validate(statusCode: 200..<201).responseJSON { response in
                        if isProgressBar! {
                            ProgressHUDManager.showProgress(visibility: false)

                        }
                        // print(response.value!)
                        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                            print("Response: \(utf8Text)") // original server data as UTF8 string
                        }

                        switch response.result {
                        case .success:
                            //Utility.print(response.result.value!)
                            success(response.result.value!)
                        case .failure(let error):
                            //Utility.print(error)

                            if let httpStatusCode = response.response?.statusCode {
                                if  httpStatusCode >= 400 && httpStatusCode < 500 {
                                    //Utility.print("client side errors 400-500")
                                }else if httpStatusCode >= 500 && httpStatusCode < 600{
                                    //Utility.print("server side errors")
                                }else if httpStatusCode == 201 {
                                    //success("Donation Set")
                                    if let data = response.data {
                                        let jsonObject = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
                                        success(jsonObject)
                                    }
                                    return
                                }
                            }
                            
                            

                            failure(error)
                        }
                }
            }
        }else{
            if isProgressBar!{
                AlertManager.showCustomInfoAlert(Title: OTConstants.kApplicationName, Message: OTConstants.KAlertNoInternetConnection, PositiveTitle: OTConstants.kAlertTypeOK,View: UIApplication.shared.keyWindow!)
            }
        }
    }
    
    func httpBody() {
        let parameters: Parameters = [
            "name": "John Doe",
            "token": "tokn_test_deadbeef",
            "amount": 100//Int(self.txtEnterDonationAmount.text ?? "0") as Any
        ]
        let urlString = "https://virtserver.swaggerhub.com/chakritw/tamboon-api/1.0.0/donations"
        let url = URL.init(string: urlString)
        Alamofire.request(url!, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result
            {
            case .success(let json):
                let jsonData = json as! Any
                print(jsonData)
            case .failure(let error):
                //self.errorFailer(error: error)
                print("Error response",error)
            }
        }
    }
    
}

