//
//  InitialViewController.swift
//  Project
//
//  Created by Thiru on 15/03/19.
//  Copyright © 2019 css. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    // Life Cycl
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialLoad()
    }

}
extension InitialViewController {
    
    private func initialLoad() {
        
        signinButton.addTarget(self, action: #selector(signinAction), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signoutAction), for: .touchUpInside)
        
    }
    private func setColor() {
        
    }
    private func setFont() {
        
    }
    private func localize() {
        
    }
}
//MARK: Button Action
extension InitialViewController {
    
    @objc func signinAction() {
        
    }
    @objc func signoutAction() {
        
    }
}
