//
//  CustomPickerViewController.swift
//  Project
//
//  Created by CSS on 26/01/19.
//  Copyright © 2019 css. All rights reserved.
//

import UIKit

class CustomPickerViewController: UIViewController {
    
    let datePickerValues = ["TODAY", "THIS WEEK", "THIS MONTH"]

    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    var dateValue = ""
    var gradeTextField: UITextField = UITextField()
    weak var delegate: CustomPickerViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pickerView.dataSource = self
        pickerView.delegate = self
        setFont()
        gradeTextField.inputView = pickerView
        gradeTextField.text = datePickerValues[0]
        customView.layer.cornerRadius = 10
    }
    
    private func setFont(){
        selectButton.titleLabel?.font =  UIFont.bold(size: 17)
        cancelButton.titleLabel?.font =  UIFont.bold(size: 17)

    }
    
    // MARK: - Select Button Action
    @IBAction func onSelectAction(_ sender: Any) {
        delegate?.setValueShowDateLabel(DateLabelValue: dateValue)
        dismiss(animated: true, completion: nil)
    }
    // MARK: - Cancel Button Action
    @IBAction func onCancelAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - UIPicker Delegate & Datasource
extension CustomPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datePickerValues.count
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.regular(size: 17)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = datePickerValues[row]
        pickerLabel?.textColor = UIColor.black
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return datePickerValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        dateValue = datePickerValues[row]
        self.view.endEditing(true)
    }
}
// MARK: - Protocol for set Value for DateWise Label
protocol CustomPickerViewControllerDelegate: class {
    func setValueShowDateLabel(DateLabelValue: String)
}
