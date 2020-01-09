//
//  OTCharitiesListController.swift
//  OmiseTest
//
//  Created by Dhananjay on 09/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import UIKit
import SDWebImage

class OTCharitiesListController: UIViewController {

    //MARK:- IBOutlets Declaration
    @IBOutlet weak var tblCharityListing: UITableView!
    @IBOutlet weak var lblNoCharityAvailable: UILabel!
    
    //MARK:- Variable Declaration
    var charityArrays = [OTData]()
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.isHidden = false
        Utility.setCasaTourNavigationBarForView(self)
        
        self.tblCharityListing.tableFooterView = UIView()
        self.callToFetchCharityListings()
    }
    
    //MARK:- WS Calls
    func callToFetchCharityListings() {
        
        OTAPIWrapperManager.callToFetchCharitiesList(KMethodType: .kTypeGET, APIName: OTConstants.kWsCharitiesList, Parameters: [:], onSuccess: { (responseData) in
            let charityListModel = responseData as? OTCharityListModel
            
            for listData in charityListModel!.data! {
                self.charityArrays.append(listData)
            }
            
            if self.charityArrays.count < 1 {
                self.tblCharityListing.isHidden = true
                self.lblNoCharityAvailable.isHidden = false
            }
            
            DispatchQueue.main.async(execute: {
                self.tblCharityListing.reloadData()
            })
            
        }) { (error) in
            AlertManager.showCustomAlert(Title: OTConstants.kApplicationName, Message: OTConstants.alertForAPIFailure, PositiveTitle: OTConstants.kAlertTypeOK, NegativeTitle: OTConstants.kAlertHideCancel, onPositive: {
                
            }, onNegative: {
                // Nothing will happen and alert gets closed.
            })
        }
    }
}

extension OTCharitiesListController:UITableViewDelegate,UITableViewDataSource {
    //MARK: - TableviewDelegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.charityArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Create seperate list item cell for listing of charity items.
        let listItemCell : OTCharityListTableViewCell = tableView.dequeueReusableCell(withIdentifier: OTCharityListTableViewCell.cellForCharitiesListingIdentifier, for: indexPath)as! OTCharityListTableViewCell
        
        let charityDetailsModel = self.charityArrays[indexPath.row]
        listItemCell.lblCharityName.text = charityDetailsModel.name
        listItemCell.imgCharityIcon.sd_setImage(with: URL.init(string: charityDetailsModel.logoUrl ?? ""), placeholderImage: UIImage.init(named: "omise_placeholder"))
        
        return listItemCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let charityDetailsModel = self.charityArrays[indexPath.row]
        let submitDonationsVC = Utility.getMainStroryBoard().instantiateViewController(withIdentifier: "OTDonationDetailsControllerViewController") as? OTDonationDetailsControllerViewController
        submitDonationsVC?.selectedCharityModel = charityDetailsModel
        self.navigationController?.pushViewController(submitDonationsVC!, animated: false)
    }
}
