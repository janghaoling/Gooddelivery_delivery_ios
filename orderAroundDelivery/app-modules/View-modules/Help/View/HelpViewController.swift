//
//  HelpViewController.swift
//  Project
//
//  Created by CSS on 02/02/19.
//  Copyright © 2019 css. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var DetailReasonLabel: UILabel!
    @IBOutlet weak var ReasonLabel: UILabel!
    @IBOutlet weak var CallButton: UIButton!
    @IBOutlet weak var chatUsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initalLoads()
        setFont()
        setColor()
        setBorders()
    }
    
    private func setColor(){
        DetailReasonLabel.textColor = UIColor.black
        ReasonLabel.textColor = UIColor.black
        CallButton.titleLabel?.textColor = UIColor.primary
        chatUsButton.titleLabel?.textColor = UIColor.primary
    }
    
    private func setBorders(){
        CallButton.layer.borderColor = UIColor.primary.cgColor
        chatUsButton.layer.borderColor = UIColor.primary.cgColor
        CallButton.layer.borderWidth = 1
        chatUsButton.layer.borderWidth = 1
    }
    
   
    private func initalLoads(){
        DetailReasonLabel.text = "Are you facing any issues which we can assist with ? Please reach out to us and we will be happy to help!".localize()
        ReasonLabel.text = "Reason".localize()
    }
    
    private func setFont(){
        ReasonLabel.font = UIFont.bold(size: 14)
        DetailReasonLabel.font = UIFont.regular(size: 14)
        CallButton.titleLabel?.font = UIFont.regular(size: 14)
        chatUsButton.titleLabel?.font = UIFont.regular(size: 14)
    }
    
    @IBAction func onChatUsButtonAction(_ sender: Any) {
    }
    

    @IBAction func onCallButtonAction(_ sender: Any) {
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
