//
//  OTCharityListTableViewCell.swift
//  OmiseTest
//
//  Created by Dhananjay on 09/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import UIKit

class OTCharityListTableViewCell: UITableViewCell {

    static let cellForCharitiesListingIdentifier: String = "cellForCharityList"

    @IBOutlet weak var lblCharityName: UILabel!
    @IBOutlet weak var imgCharityIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
