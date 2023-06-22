//
//  SignInViewController.swift
//  Project
//
//  Created by CSS on 08/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import UIKit
import Crashlytics

class SignInViewController: UIViewController {

    @IBOutlet private weak var textFieldMobileNumber : UITextField!
    @IBOutlet private weak var butttonContinue : UIButton!
    @IBOutlet private weak var viewCountryCode : UIView!
    @IBOutlet private weak var labelCountryCode : UILabel!
    @IBOutlet private weak var imageViewCode : UIImageView!
    var keyboardShow:Bool=false

    private var countryDetail : Country? {
        didSet {
            if countryDetail != nil {
                self.imageViewCode.image = UIImage(named: "CountryPicker.bundle/"+countryDetail!.code)
                self.labelCountryCode.text = countryDetail?.dial_code
            }
        }
    }
    
    private var number : String = .Empty
    
    private lazy var loader : UIView = {
        return createLottieLoader(in: self.view)
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalLoads()
    }
    @IBAction func crashButtonTapped(_ sender: AnyObject) {
        Crashlytics.sharedInstance().crash()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        enableKeyboardHandling()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disableKeyboardHandling()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.layouts()
    }
    
}

// MARK:- UIViewStructure
extension SignInViewController : UIViewStructure {
    
    func initalLoads() {
        self.localize()
        self.design()
        self.addToolBarTextField(textField: textFieldMobileNumber)
        self.hideKeyboardWhenTappedAround()
        self.viewCountryCode.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewCountryCodeTapAction)))
        if let code = Common.getCurrentCode(){
            self.countryDetail = Common.getCountries().filter({ $0.code == code}).first
        }
        textFieldMobileNumber.tintColor = UIColor.primary
        
    }
    
    func localize() {
        self.textFieldMobileNumber.placeholder = APPLocalize.localizestring.enterMobileNumber.localize()
        self.butttonContinue.setTitle(APPLocalize.localizestring.continueText.localize().uppercased(), for: .normal)
    }
    
    func design() {
        Common.setFont(to: textFieldMobileNumber, fontType : .bold)
        Common.setFont(to: butttonContinue)
        Common.setFont(to: labelCountryCode, fontType : .bold)
    }
    
    func layouts() {
    }
    
}

// MARK:- Actions
extension SignInViewController  {
    
    // Button Continue Action
    
    @IBAction private func buttonContinueAction() {
        self.view.endEditingForce()
        guard countryDetail != nil else {
            self.view.make(toast: APPLocalize.localizestring.selectCountryCode.localize())
            return
        }
        
        guard let mobileNumber = textFieldMobileNumber.text, !mobileNumber.isEmpty else {
            self.view.make(toast: APPLocalize.localizestring.enterMobileNumber.localize())
            return
        }
        guard textFieldMobileNumber.text?.count ?? 0 > 7 else {
            self.view.make(toast: APPLocalize.localizestring.inValidPhoneNumber.localize())
            
            return
        }
        guard textFieldMobileNumber.text?.count ?? 0 < 15 else {
            self.view.make(toast: APPLocalize.localizestring.inValidPhoneNumber.localize())
            
            return
        }
        number = countryDetail!.dial_code+mobileNumber
        self.loader.isHidden = false
        var loginRequest = LoginEntity()
        loginRequest.phone = number
        self.presenter?.post(api: .login, data: loginRequest.toData())
        
    }
    
    //MARK:- Country Code Action
    
    @IBAction private func viewCountryCodeTapAction() {
        
        if let countryVC = Router.main.instantiateViewController(withIdentifier: Storyboard.Ids.CountryCodeController) as? CountryCodeController {
            countryVC.countryCode = { [weak self] countryDetail in
                self?.countryDetail = countryDetail
            }
            self.navigationController?.pushViewController(countryVC, animated: true)
        }
        
    }
    
    func settingServiceCall() {
        self.presenter?.get(api: .settings, data: nil)
    }
    
    
}


// MARK:- PostViewProtocol

extension SignInViewController : PostViewProtocol {
    
    func onError(api: Base, message: String, statusCode code: Int) {
        loader.isHideInMainThread(true)
        UIApplication.shared.keyWindow?.make(toast: message)
    }
    
    func getSettingsData(api: Base, data: SettingsEntity?) {
        
        //  Common.storeUserData(from: data)
        print("check",data?.ios_api_key ?? "")
        
        //GMSServices.provideAPIKey(data?.ios_api_key ?? "")
       // GMSPlacesClient.provideAPIKey(data?.ios_api_key ?? "")
        googleMapKey = data?.ios_api_key ?? ""
        appSecretKey = data?.client_secret ?? ""
    
    }
    
    
    func getLoginEntity(api: Base, entity: LoginEntity?) {
       
        loader.isHideInMainThread(true)
        if let otp = entity?.otp, let verficationVC = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.VerificationViewController) as? VerificationViewController {
//            verficationVC.isMobileVerified = {[weak self] isVerified in
//                guard let self = self else {return}
//                if isVerified {
//                    self.present(Common.setDrawerController(), animated: true, completion: nil)
//                }
//            }
            self.navigationController?.pushViewController(verficationVC, animated: true)
            verficationVC.set(mobile: number , otp: String(otp))
        }
        
    }
    
}
