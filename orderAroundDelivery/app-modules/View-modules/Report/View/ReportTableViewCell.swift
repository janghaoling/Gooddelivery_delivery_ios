//
//  ReportTableViewCell.swift
//  Project
//
//  Created by CSS on 02/02/19.
//  Copyright © 2019 css. All rights reserved.
//

import UIKit

class ReportTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setFont()
    }
    private func setFont(){
        titleLabel.font = UIFont.regular(size: 14)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
