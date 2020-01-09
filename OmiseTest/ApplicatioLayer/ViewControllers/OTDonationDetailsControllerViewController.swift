//
//  OTDonationDetailsControllerViewController.swift
//  OmiseTest
//
//  Created by Dhananjay on 09/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import UIKit
import MFCard
import SkyFloatingLabelTextField

class OTDonationDetailsControllerViewController: UIViewController {

    //MARK:- IBOutlets Declaration
    @IBOutlet weak var creditCardView: MFCardView!
    @IBOutlet weak var lblCharityName: UILabel!
    @IBOutlet weak var txtEnterDonationAmount: SkyFloatingLabelTextField!
    
    //MARK:- Variable Declaration
    var selectedCharityModel = OTData.init(object: "")
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        Utility.setCasaTourNavigationBarForView(self)
        
        self.lblCharityName.text = "Please enter your donation amount (THB) for \(self.selectedCharityModel.name ?? "Charity")."
        self.txtEnterDonationAmount.becomeFirstResponder()
        
        self.showCreditCardForm()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.hidesBackButton = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK:- Class Methods
    // Define the attributes for CreditCard form view.
    func showCreditCardForm() {
        creditCardView.autoDismiss = false
        creditCardView.toast = false
        creditCardView.delegate = self
        creditCardView.controlButtonsRadius = 5
        creditCardView.cardRadius = 5
    }
    
    // API call for submitting donation amount to selected charity
    func callToSubmitDonationForCharity(userName:String) {
        
        let reqstParams:[String:Any] = [
            "name": userName ,
            "token": "tokn_test_deadbeef",
            "amount": Int(self.txtEnterDonationAmount.text ?? "0") as Any
        ]

        OTAPIWrapperManager.callToSubmitDonations(KMethodType: .kTypePOST, APIName: OTConstants.kWsMakeDonation, Parameters: reqstParams, onSuccess: { (responseData) in
            
            print(" Donation status --> ", responseData)
            if let status = (responseData as? NSDictionary)?.object(forKey: "success") {
                if ((status as? Bool)!) {
                    let successScreen = Utility.getMainStroryBoard().instantiateViewController(withIdentifier: "OTDonationSuccessController") as? OTDonationSuccessController
                    self.navigationController?.pushViewController(successScreen!, animated: false)
                }
            }
            
        }) { (error) in
            AlertManager.showCustomInfoAlert(Title: OTConstants.kApplicationName, Message: OTConstants.alertForAPIFailure, PositiveTitle: OTConstants.kAlertTypeOK, View: self.view)
        }
    }
}

// MARK:- Delegate methods for MFCard
extension OTDonationDetailsControllerViewController : MFCardDelegate {
    
    //This function will get called after all card form validations.
    func cardDoneButtonClicked(_ card: Card?, error: String?) {
        
        if txtEnterDonationAmount.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            AlertManager.showCustomInfoAlert(Title: OTConstants.kApplicationName, Message: OTConstants.KAlertEnterValidAmount, PositiveTitle: OTConstants.kAlertTypeOK, View: self.view)
            return
        }else if error != nil {
            AlertManager.showCustomInfoAlert(Title: OTConstants.kApplicationName, Message: error!, PositiveTitle: OTConstants.kAlertTypeOK, View: self.view)
            return
        }
        
        //call for submit donations
        self.callToSubmitDonationForCharity(userName: card?.name ?? "NA")
    }
    
    func cardTypeDidIdentify(_ cardType: String) {
        
    }
    
    func cardDidClose() {
        
    }
}

//MARK:- UITextField Delegate methods.
extension OTDonationDetailsControllerViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            return false
        }
        
        return true
    }
}
