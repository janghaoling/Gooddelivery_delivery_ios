//
//  ShiftStatusHeader.swift
//  Project
//
//  Created by CSS on 22/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import UIKit

class ShiftStatusHeader: UIView {

    @IBOutlet private weak var labelAmountOwned : Label!
    @IBOutlet private weak var labelStartShiftString : UILabel!
    @IBOutlet private weak var labelTime : Label!
    @IBOutlet private weak var viewShift : UIView!
    
    private var amount : Float = 0 {
        didSet {
            guard self.labelAmountOwned != nil  else { return }
            let text = APPLocalize.localizestring.youOwned.localize()
            let value = "\(String.removeNil(User.main.currency)) \(Formatter.shared.limit(string: "\(amount)", maximumDecimal: currencyDecimalLimit))"
            self.labelAmountOwned.text = text+" "+value
            self.labelAmountOwned.startLocation = text.count
            self.labelAmountOwned.length = value.count+1
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.localize()
        self.setFont()
    }
    
    // Set Font
    private func setFont() {
        Common.setFont(to: labelAmountOwned, size : 20, fontType : .bold)
        Common.setFont(to: labelTime, size: 10)
        Common.setFont(to: labelStartShiftString, size : 16)
        self.labelAmountOwned.attributeColor = .primary
    }
    
    func set(amount : Float, time : String) {
        self.amount = amount
        self.labelTime.text = time
    }
    
    
    // localize
    private func localize() {
        self.labelStartShiftString.text = APPLocalize.localizestring.startShift.localize()
    }

}
