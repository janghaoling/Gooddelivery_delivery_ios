//
//  PickerView.swift
//  Project
//
//  Created by CSS on 27/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import Foundation
import UIKit

class PickerView : UIView {
    
    @IBOutlet private weak var buttonCancel : Button!
    @IBOutlet private weak var buttonDone : Button!
    @IBOutlet private weak var pickerViewList : UIPickerView!
    
    private var datasource = [String]()
    var onClickDone : ((Int)->Void)?
    var onClickCancel : (()->Void)?
    
    private var selectedIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialLoads()
    }
    
}

extension PickerView {
    
    private func initialLoads() {
        self.localize()
        self.setFont()
        self.pickerViewList.dataSource = self
        self.pickerViewList.delegate = self
        self.buttonCancel.addTarget(self, action: #selector(self.buttonAction(sender:)), for: .touchUpInside)
        self.buttonDone.addTarget(self, action: #selector(self.buttonAction(sender:)), for: .touchUpInside)
    }
    
    private func localize() {
        buttonDone.setTitle(APPLocalize.localizestring.Done.localize(), for: .normal)
        buttonCancel.setTitle(APPLocalize.localizestring.Cancel.localize(), for: .normal)
    }
    
    private func setFont() {
        Common.setFont(to: buttonDone)
        Common.setFont(to: buttonCancel)
    }
    
    @IBAction private func buttonAction(sender : UIButton) {
        if sender == buttonDone {
            self.onClickDone?(selectedIndex)
        }else {
            self.onClickCancel?()
        }
    }
    
    // Set DataValues
    
    func setValues(data : [String]) {
        self.datasource = data
        self.pickerViewList.reloadAllComponents()
    }
    
}

extension PickerView : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datasource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if self.datasource.count > row {
            return self.datasource[row]
        }
        return nil
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedIndex  = row
    }
}

