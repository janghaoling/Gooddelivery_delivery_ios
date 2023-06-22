//
//  CountryTableViewCell.swift
//  User
//
//  Created by CSS on 20/02/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet private var imageViewCountry : UIImageView!
    @IBOutlet private var labelCountry : UILabel!
    @IBOutlet private var labelCode : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK:- Setting Values in Cell From Country Object 

    func set(values : Country){
        
        self.imageViewCountry.image = UIImage(named: "CountryPicker.bundle/"+values.code)
        self.labelCode.text = values.code
        self.labelCountry.text = "(\(values.dial_code))"+values.name
        
    }

}
