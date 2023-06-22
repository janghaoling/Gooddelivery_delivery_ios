//
//  AmountPopViewViewController.swift
//  Project
//
//  Created by CSS on 31/01/19.
//  Copyright © 2019 css. All rights reserved.
//

import UIKit



class AmountPopViewViewController: UIViewController {

    @IBOutlet weak var amountBoxView: UIView!
    @IBOutlet weak var amountPaidOverView: UIView!
    @IBOutlet weak var balanceValueLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var enterAmountTextField: UITextField!
    @IBOutlet weak var enterAmountLabel: UILabel!
    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var thirdOtpTextField: UITextField!
    @IBOutlet weak var fourthOtpTextField: UITextField!
    @IBOutlet weak var fifthOtpTextField: UITextField!
    @IBOutlet weak var sixthOtpTextField: UITextField!
    @IBOutlet weak var paidButton: UIButton!
    @IBOutlet weak var secondOtpTextField: UITextField!
    @IBOutlet weak var firstOtpTextField: UITextField!
    @IBOutlet weak var enterOtpLabel: UILabel!
    @IBOutlet weak var amountToPayValueLabel: UILabel!
    @IBOutlet weak var amountToPayLabel: UILabel!
    @IBOutlet weak var topview: UIView!
    
    var order_otp = ""
    var Data: OrdersEntity?
    weak var delegate: AmountPopViewViewControllerDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initalLoads()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        enableKeyboardHandling()
    }
    override func viewWillDisappear(_ animated: Bool) {
        disableKeyboardHandling()
    }
    
    private func initalLoads(){
        setFont()
        setColor()
        setDelegateTextField()
        setData()
    }
    // setting Value to Labels
    private func setData(){
        amountBoxView.layer.borderColor = UIColor.black.cgColor
        amountBoxView.layer.borderWidth = 1
        enterAmountTextField.tintColor = UIColor.liveTaskColor
        firstOtpTextField.tintColor = UIColor.liveTaskColor
        fifthOtpTextField.tintColor = UIColor.liveTaskColor
        secondOtpTextField.tintColor = UIColor.liveTaskColor
        thirdOtpTextField.tintColor = UIColor.liveTaskColor
        fourthOtpTextField.tintColor = UIColor.liveTaskColor
        sixthOtpTextField.tintColor = UIColor.liveTaskColor
        paidButton.layer.cornerRadius = 10
        balanceValueLabel.text = "\(APPLocalize.localizestring.Currency.localize())0"
        amountPaidOverView.layer.cornerRadius = 10
        order_otp = "\(Data!.order_otp!)"
        let amtToPayStr =  "\(Data!.invoice!.payable!)"
        amountToPayValueLabel.text = APPLocalize.localizestring.Currency.localize() + amtToPayStr
        enterAmountTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    // Set Delegate TextField
    private func setDelegateTextField(){
        fifthOtpTextField.delegate = self
        firstOtpTextField.delegate = self
        secondOtpTextField.delegate = self
        thirdOtpTextField.delegate = self
        fourthOtpTextField.delegate = self
        sixthOtpTextField.delegate = self
        enterAmountTextField.delegate = self
        addToolBarTextField(textField: firstOtpTextField)
        addToolBarTextField(textField: secondOtpTextField)
        addToolBarTextField(textField: thirdOtpTextField)
        addToolBarTextField(textField: fourthOtpTextField)
        addToolBarTextField(textField: fifthOtpTextField)
        addToolBarTextField(textField: sixthOtpTextField)
        addToolBarTextField(textField: enterAmountTextField)

    }
    // Set Font
    private func setFont(){
        paidButton.titleLabel?.font = UIFont.regular(size: 14)
        amountToPayLabel.font = UIFont.regular(size: 14)
        enterAmountTextField.font = UIFont.regular(size: 14)
        balanceValueLabel.font = UIFont.regular(size: 14)
        amountToPayValueLabel.font = UIFont.regular(size: 14)
        balanceLabel.font = UIFont.regular(size: 14)
        fifthOtpTextField.font = UIFont.regular(size: 14)
        firstOtpTextField.font = UIFont.regular(size: 14)
        secondOtpTextField.font = UIFont.regular(size: 14)
        sixthOtpTextField.font = UIFont.regular(size: 14)
        thirdOtpTextField.font = UIFont.regular(size: 14)
        fourthOtpTextField.font = UIFont.regular(size: 14)
        enterAmountLabel.font = UIFont.regular(size: 14)
    }
    // Set Color
    private func setColor(){
        paidButton.setTitleColor(UIColor.white, for: .normal)
        paidButton.backgroundColor = UIColor.baseColor
        amountToPayLabel.textColor = UIColor.black
        enterAmountTextField.textColor = UIColor.baseColor
        balanceValueLabel.textColor = UIColor.baseColor
        amountToPayValueLabel.textColor = UIColor.baseColor
        balanceLabel.textColor = UIColor.black
        fifthOtpTextField.textColor = UIColor.black
        firstOtpTextField.textColor = UIColor.black
        secondOtpTextField.textColor = UIColor.black
        thirdOtpTextField.textColor = UIColor.black
        fourthOtpTextField.textColor = UIColor.black
        enterAmountLabel.textColor = UIColor.black
        sixthOtpTextField.textColor = UIColor.black
        topview.backgroundColor = UIColor.baseColor
        
    }
    // Paid Button Action
    @IBAction func paidAction(_ sender: Any) {
        
        let getStr = amountToPayValueLabel.text
        let removeStr = getStr!.replacingOccurrences(of: APPLocalize.localizestring.Currency.localize(), with: "")
        
        let validOtp = "\(firstOtpTextField.text ?? "")\(secondOtpTextField.text ?? "")\(thirdOtpTextField.text ?? "")\(fourthOtpTextField.text ?? "")\(fifthOtpTextField.text ?? "")\(sixthOtpTextField.text ?? "")"
        
        let enterAmount = enterAmountTextField.text?.trim()
        
        if !(validOtp == order_otp) {
            self.view.make(toast: "Invalid Otp !!".localize())

        } else if enterAmount?.count == 0 {
            self.view.make(toast: "Please enter the amount paid by the customer".localize())

        } else if Int(enterAmountTextField.text!)! < Int(removeStr) ?? 0 {
            self.view.make(toast: "Please enter the amount to be paid".localize())

        } else {
            
            self.dismiss(animated: true, completion: nil)
            delegate?.AmountPaid(balanceAmt: balanceValueLabel.text!,enterAmt: enterAmountTextField.text!)


        }
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
// MARK: - TextFeild Delegate
extension AmountPopViewViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField.text?.count ?? 0) == 0 {
            
            balanceValueLabel.text = "\(APPLocalize.localizestring.Currency.localize())0"
            print("\(balanceValueLabel.text ?? "")")
        } else if (textField.text == "0") {
            
            balanceValueLabel.text = "\(APPLocalize.localizestring.Currency.localize())0"
            print("\(balanceValueLabel.text ?? "")")
        } else {
            
            balanceValueLabel.text = "\(APPLocalize.localizestring.Currency.localize())\(makeSubraction(enterAmountTextField.text, getSecond: amountToPayValueLabel.text) ?? "")"
            print("\(balanceValueLabel.text ?? "")")
        }
        
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == firstOtpTextField) || textField == secondOtpTextField || textField == thirdOtpTextField || textField == fourthOtpTextField || textField == fifthOtpTextField || textField == sixthOtpTextField {
            
            if string.count > 0 && !Scanner(string: string).scanInt32(nil) {
                return false
            }
            
            let oldLength: Int = textField.text?.count ?? 0
            let replacementLength: Int = string.count
            let rangeLength = Int(range.length)
            
            let newLength: Int = oldLength - rangeLength + replacementLength
            
            if newLength == 1 {
                if textField == firstOtpTextField {
                    perform(#selector(self.nextResponder), with: secondOtpTextField, afterDelay: 0.1)
                } else if textField == secondOtpTextField {
                    perform(#selector(self.nextResponder), with: thirdOtpTextField, afterDelay: 0.1)
                } else if textField == thirdOtpTextField {
                    perform(#selector(self.nextResponder), with: fourthOtpTextField, afterDelay: 0.1)
                } else if textField == fourthOtpTextField {
                    perform(#selector(self.nextResponder), with: fifthOtpTextField, afterDelay: 0.1)
                } else if textField == fifthOtpTextField {
                    perform(#selector(self.nextResponder), with: sixthOtpTextField, afterDelay: 0.1)
                } else if textField == sixthOtpTextField {
                    perform(#selector(self.nextResponder), with: enterAmountTextField, afterDelay: 0.0)
                }
            }
            
            return newLength <= 1;
        }
        else
        {
            return true
        }
    }
    
    //become first Responder menthod
    @objc func nextResponder(nextResponder: UITextField){
        nextResponder.becomeFirstResponder()
    }
    
    //Subraction of two String
    func makeSubraction(_ firstStr: String?, getSecond secondStr: String?) -> String? {
        let getStr = secondStr
        let firstremoveStr = getStr?.replacingOccurrences(of: APPLocalize.localizestring.Currency.localize(), with: "")
        let secondremoveStr = firstStr?.replacingOccurrences(of: APPLocalize.localizestring.Currency.localize(), with: "")
        let firstInt:Int = Int(firstremoveStr!)!
        let secondInt:Int = Int(secondremoveStr!)!
        let getSubractedStr = (secondInt) - (firstInt)
        print(getSubractedStr)
        return String(getSubractedStr)
        
    }

}
// MARK: - Protocol for set Value for DateWise Label
protocol AmountPopViewViewControllerDelegate: class {
    func AmountPaid(balanceAmt: String,enterAmt: String)
}

