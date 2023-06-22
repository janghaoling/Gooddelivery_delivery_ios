//
//  DisputeViewController.swift
//  Project
//
//  Created by CSS on 02/02/19.
//  Copyright © 2019 css. All rights reserved.
//

import UIKit

class DisputeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var orderIdValueLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    
    @IBOutlet weak var overView: UIView!
    
    var phoneNumberStr = ""
    var Data: OrdersEntity?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initalLoads()
        print(Data)
    }
    // initalLoads
    private func initalLoads(){
        setFont()
        setColor()
        setDataValues()
        setCornerRadius()
    }
    // set DataValues
    private func setDataValues(){
            orderIdValueLabel.text = "#" + "\(Data!.id!)"
        if Data!.dispute_manager?.count != 0 {
            phoneNumberStr = Data!.dispute_manager![0].phone!
        }else{
           phoneNumberStr = ""
        }
    }
    
    @IBAction func onClickDissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    // set CornerRadius
    private func setCornerRadius(){
        cancelButton.layer.cornerRadius = 5
        callButton.layer.cornerRadius = 5
        overView.layer.cornerRadius = 8
    }
    // set Font
    private func setFont(){
        titleLabel.font = UIFont.bold(size: 15)
        subTitleLabel.font = UIFont.regular(size: 14)
        orderIdLabel.font = UIFont.bold(size: 15)
        orderIdValueLabel.font = UIFont.bold(size: 15)
        cancelButton.titleLabel?.font = UIFont.regular(size: 14)
        callButton.titleLabel?.font = UIFont.regular(size: 14)
    }
    // set Colors
    private func setColor(){
        titleLabel.textColor = UIColor.black
        subTitleLabel.textColor = UIColor.black
        orderIdLabel.textColor = UIColor.black
        orderIdValueLabel.textColor = UIColor.black
        cancelButton.setTitleColor(UIColor.white, for: .normal)
        callButton.setTitleColor(UIColor.white, for: .normal)
        callButton.backgroundColor = UIColor.baseColor
        cancelButton.backgroundColor = UIColor.baseColor
    }
    // Localize
    private func Localize(){
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // Call button Action
    @IBAction func onCallAction(_ sender: Any) {
        let phoneNumber = "tel://" + ("\(phoneNumberStr)")
        if let url = URL(string: phoneNumber) {
            UIApplication.shared.open(url, options: [
                UIApplication.OpenExternalURLOptionsKey(rawValue: ""): ""
                ], completionHandler: nil)
        }
    }
    // Cancel button Action
    @IBAction func onCancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
