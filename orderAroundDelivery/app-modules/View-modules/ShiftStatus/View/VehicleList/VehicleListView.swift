//
//  VehicleListView.swift
//  Project
//
//  Created by CSS on 27/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import UIKit

class VehicleListView: UIView {
    
    @IBOutlet private weak var buttonContinue : UIButton!
    @IBOutlet weak var buttonList : UIButton!
    @IBOutlet private weak var labelVehicleTitle : UILabel!
    @IBOutlet private weak var textFieldVehicle : UITextField!
    @IBOutlet private weak var labelORText : UILabel!
    var onclickContinue : ((String)->Void)?
    var onclickList : (((@escaping (String?)->Void))->Void)?
    private var datasourceCount  = 0
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialLoads()
    }

}

extension VehicleListView: UITextFieldDelegate {
    
    private func initialLoads() {
        self.localize()
        self.setFont()
        self.buttonContinue.addTarget(self, action: #selector(self.buttonContinueAction), for: .touchUpInside)
        self.buttonList.addTarget(self, action: #selector(self.buttonListAction), for: .touchUpInside)
        textFieldVehicle.delegate = self
        textFieldVehicle.tintColor = UIColor.liveTaskColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Localize
    
    private func localize() {
       // self.localizeCount()
        self.labelORText.text = APPLocalize.localizestring.or.localize().uppercased()
        self.labelVehicleTitle.text = APPLocalize.localizestring.enterTheVehicleNumber.localize()
        self.buttonContinue.setTitle(APPLocalize.localizestring.continueText.localize().uppercased(), for: .normal)
    }
    
    private func localizeCount() {
        
    }
    
    // Set Datasource count
    
    func setDatasource(count : Int) {
        self.datasourceCount = count
        localizeCount()
    }
    
    
    
    // Set Font
    
    private func setFont() {
        Common.setFont(to: buttonList,fontType : .meduim)
        Common.setFont(to: labelVehicleTitle)
        Common.setFont(to: textFieldVehicle)
        Common.setFont(to: buttonContinue, fontType : .bold)
    }
    
    // MARK:- Continue Button Action
    @IBAction private func buttonContinueAction() {
        guard let selectedVehicle = self.textFieldVehicle.text, !selectedVehicle.isEmpty else {
            UIApplication.shared.keyWindow?.make(toast: APPLocalize.localizestring.selectVehicle.localize())
            return
        }
        self.onclickContinue?(selectedVehicle)
    }
    
    // MARK:- Button List Action
    
    @IBAction private func buttonListAction() {
        self.onclickList!({ [weak self] selectedString in
            self?.textFieldVehicle.text = selectedString
            if selectedString == nil {
                self?.localizeCount()
            } else {
                self?.buttonList.setTitle(selectedString, for: .normal)
            }
        })
    }
    
}
