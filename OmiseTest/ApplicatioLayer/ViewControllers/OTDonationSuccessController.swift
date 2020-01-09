//
//  OTDonationSuccessController.swift
//  OmiseTest
//
//  Created by Dhananjay on 09/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import UIKit

class OTDonationSuccessController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        Utility.setCasaTourNavigationBarForView(self)
        self.navigationItem.hidesBackButton = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will of
     ten want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK:- IBActions
    @IBAction func btnDismissClicked(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
}
