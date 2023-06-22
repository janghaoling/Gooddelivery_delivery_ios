
//
//  TotalPaymentView.swift
//  Project
//
//  Created by CSS on 26/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import UIKit

class TotalPaymentView: UIView {

    @IBOutlet private weak var labelAmountTobePaidString : UILabel!
    @IBOutlet private weak var labelAmountTobePaid : Label!
    @IBOutlet private weak var labelAmountHandoverString : UILabel!
    @IBOutlet weak var buttonEndShift : UIButton!
    
    var onclickEndShift : (()->Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialLoads()
    }
}


extension TotalPaymentView  {
   
    
    
    private func initialLoads() {
       self.localize()
       self.setDesign()
        self.buttonEndShift.addTarget(self, action: #selector(self.buttonEndShiftAction), for: .touchUpInside)
    }
    
    private func localize() {
        self.buttonEndShift.setTitle(APPLocalize.localizestring.Done.localize(), for: .normal)
        self.labelAmountHandoverString.text = APPLocalize.localizestring.handovertheAmount.localize()
        self.labelAmountTobePaidString.text = APPLocalize.localizestring.amountTobePaid.localize()
    }
    
    private func setDesign() {
        
        Common.setFont(to: labelAmountTobePaidString, size: 18, fontType : .bold)
        Common.setFont(to: labelAmountTobePaid, size: 22, fontType : .bold)
        Common.setFont(to: labelAmountHandoverString, size: 16, fontType : .semiBold)
        Common.setFont(to: buttonEndShift, size: 16, fontType : .semiBold)

    }
    
    // Set Amount Value
    
    func setValue(amount : String, shiftstatus : ShiftStatus) {
        self.labelAmountTobePaid.text = "\(String.removeNil(User.main.currency)) \(amount)"
        self.buttonEndShift.setTitle((shiftstatus == .started ? APPLocalize.localizestring.endShift.localize() : APPLocalize.localizestring.Done.localize()).localize(), for: .normal)
    }
    
    @IBAction private func buttonEndShiftAction() {
        self.onclickEndShift?()
    }
    
}
