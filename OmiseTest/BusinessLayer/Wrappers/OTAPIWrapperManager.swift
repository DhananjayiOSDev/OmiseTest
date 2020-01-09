//
//  OTAPIWrapperManager.swift
//  OmiseTest
//
//  Created by Dhananjay on 09/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import UIKit

class OTAPIWrapperManager: NSObject {
    
    typealias OnSuccessCompletionHandler = (_ receivedString: Any) -> Void
    typealias OnProgressCompletionHandler = (_ receivedString: Progress) -> Void
    typealias OnFailureCompletionHandler = (_ error: Error?) -> Void


    static func callToFetchCharitiesList(KMethodType method:OTAPIRequestManager.kMethodType ,APIName strAPI: String,
                                      Parameters parameters: [String: Any] , onSuccess success:@escaping OnSuccessCompletionHandler , onFailure failure: @escaping OnFailureCompletionHandler) {
        
        OTAPIRequestManager.callAPI(KMethodType: method, APIName: strAPI, Parameters: parameters, onSuccess: { responseData in
            let charityListModel = OTCharityListModel.init(object: responseData)
            success(charityListModel)
        }) { (error) in
            failure(error)
        }
    }
    
    static func callToSubmitDonations(KMethodType method:OTAPIRequestManager.kMethodType ,APIName strAPI: String,
                                         Parameters parameters: [String: Any] , onSuccess success:@escaping OnSuccessCompletionHandler , onFailure failure: @escaping OnFailureCompletionHandler) {
        
        OTAPIRequestManager.callAPI(KMethodType: method, APIName: strAPI, Parameters: parameters, onSuccess: { responseData in
            success(responseData)
        }) { (error) in
            failure(error)
        }
    }

}

