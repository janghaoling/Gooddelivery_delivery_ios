//
//  ItemWithoutAddOnsTableViewCell.swift
//  Project
//
//  Created by CSS on 07/02/19.
//  Copyright © 2019 css. All rights reserved.
//

import UIKit

class ItemWithoutAddOnsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setFont()
        setColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setFont(){
        titleLabel.font = UIFont.bold(size: 15)
        descriptionLabel.font = UIFont.bold(size: 15)
    }
    
    func setColor(){
        titleLabel.textColor =  UIColor.descDarkColor
        descriptionLabel.textColor = UIColor.descDarkColor
    }
    
}
