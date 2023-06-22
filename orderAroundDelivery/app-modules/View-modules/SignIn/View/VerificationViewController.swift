//
//  VerificationViewController.swift
//  Project
//
//  Created by CSS on 09/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import UIKit

class VerificationViewController: UIViewController {
    
    @IBOutlet private weak var textView1 : UITextView!
    @IBOutlet private weak var textView2 : UITextView!
    @IBOutlet private weak var textView3 : UITextView!
    @IBOutlet private weak var textView4 : UITextView!
    @IBOutlet private weak var textView5 : UITextView!
    @IBOutlet private weak var textView6 : UITextView!
    @IBOutlet private weak var labelVerficationString : UILabel!
    @IBOutlet private weak var labelVerficationCodeSentString : Label!
    @IBOutlet private weak var buttonContinue : UIButton!
    @IBOutlet private weak var imageViewBack : UIImageView!
    private lazy var textFieldsArray = [self.textView1,self.textView2,self.textView3,self.textView4,self.textView5,self.textView6]
    private var mobileNumber : String = .Empty
    
    private var otp : String = .Empty
    
    private lazy var loader : UIView = {
        return createLottieLoader(in: self.view)
    }()
    //var isMobileVerified : ((Bool)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalLoads()
    }
    override func viewDidAppear(_ animated: Bool) {
        enableKeyboardHandling()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        disableKeyboardHandling()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.layouts()
    }
    
}

extension VerificationViewController : UIViewStructure {
    
    func initalLoads() {
        self.design()
        localize()
        setDelegateTextField()
        self.view.dismissKeyBoardonTap()
        labelVerficationCodeSentString.textAlignment = .left
        self.buttonContinue.addTarget(self, action: #selector(self.buttonContinueAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: ImageString.imageValue.backicon), style: .done, target: self, action: #selector(self.backButtonClick))
    }
    
     func setDelegateTextField(){
        addToolBarTextView(textView: textView1)
        addToolBarTextView(textView: textView2)
        addToolBarTextView(textView: textView3)
        addToolBarTextView(textView: textView4)
        addToolBarTextView(textView: textView5)
        addToolBarTextView(textView: textView6)

        textView1.tintColor = UIColor.primary
        textView2.tintColor = UIColor.primary
        textView3.tintColor = UIColor.primary
        textView4.tintColor = UIColor.primary
        textView5.tintColor = UIColor.primary
        textView6.tintColor = UIColor.primary
        textView1.delegate = self
        textView2.delegate = self
        textView3.delegate = self
        textView4.delegate = self
        textView5.delegate = self
        textView6.delegate = self
        textFieldsArray.forEach { (textField) in
            Common.setFont(to: textField!, size : 16, fontType : FontCustom.extraBold)
            textField?.delegate = self
            textField?.contentMode = .center
            textField?.addShadow(color: .lightGray, opacity: 1, offset: CGSize(width: 0.1, height: 0.1), radius: 10, rasterize: false, maskToBounds: true)
        }
    }
    
     func localize() {
        self.buttonContinue.setTitle(APPLocalize.localizestring.continueText.localize().uppercased(), for: .normal)
        self.labelVerficationString.text = APPLocalize.localizestring.verficationCode.localize()
        let textString = APPLocalize.localizestring.verficationSentText.localize()+" \(mobileNumber)"
        self.labelVerficationCodeSentString.text = textString
        self.labelVerficationCodeSentString.startLocation = (textString.count-" \(mobileNumber)".count)
        self.labelVerficationCodeSentString.length = " \(mobileNumber)".count
        self.labelVerficationCodeSentString.attributeColor = .primary
    }
    
    func design() {
        Common.setFont(to: labelVerficationString, isTitle: true, size: 20, fontType: .black)
        labelVerficationString.textColor = .darkGray
        Common.setFont(to: labelVerficationCodeSentString, isTitle: false, size: 10, fontType: .light)
        labelVerficationCodeSentString.textColor = .gray
        Common.setFont(to: buttonContinue)

    }
    
    func layouts() {
        
    }
    
    // Setting mobile number and from SignIn View Controller 3
    func set(mobile mobileNumber : String, otp : String) {
        self.mobileNumber = mobileNumber
        self.otp = otp
    }
    
}

// MARK:- Actions

extension VerificationViewController {
    
    @IBAction private func buttonContinueAction() {
        
        self.view.endEditingForce()
        var otpEntered : String = .Empty
        for textField in textFieldsArray {
            guard let textFieldOtp = textField?.text, !textFieldOtp.isEmpty else {
                self.view.makeToast(APPLocalize.localizestring.enterOtp.localize())
                return
            }
            otpEntered += textFieldOtp
        }
        
        loader.isHidden = false
        var verifyRequest = LoginEntity()
        verifyRequest.phone = mobileNumber
        verifyRequest.otp = Int(otpEntered)
        self.presenter?.post(api: .verifyOtp, data: verifyRequest.toData())
        
//        if self.otp == otpEntered {
//            loader.isHidden = false
//            var verifyRequest = LoginEntity()
//            verifyRequest.phone = mobileNumber
//            verifyRequest.otp = Int(otpEntered)
//            self.presenter?.post(api: .verifyOtp, data: verifyRequest.toData())
//        }else {
//            self.view.make(toast: APPLocalize.localizestring.otpIncorrect.localize())
//        }
        
    }
    
    
}


// MARK:- UITextViewDelegate

extension VerificationViewController : UITextViewDelegate {
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        self.makeResponsive(textView: textView)
        
        if textView.text.count>1, var text = textView.text {
            text.removeFirst()
            textView.text = text
        }
        
        
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        if Int.val(val: textView.text?.count)>1, var text = textView.text {
            text.removeFirst()
            textView.text = text
        }
        
        if textView.text.count>=1 {
            if textFieldsArray[textFieldsArray.count-1] == textView {
                textView.resignFirstResponder()
            } else {
                if let index = textFieldsArray.firstIndex(where: { $0 == textView}) {
                    textFieldsArray[index+1]?.becomeFirstResponder()
                }else {
                    textView.resignFirstResponder()
                }
            }
        }
    }
    
    private func makeResponsive(textView : UITextView){
        textFieldsArray.forEach { (field) in
            field?.layer.masksToBounds = !(textView == field)
        }
    }
    
}

// MARK:- PostViewProtocol

extension VerificationViewController : PostViewProtocol {
    
    func onError(api: Base, message: String, statusCode code: Int) {
        loader.isHideInMainThread(true)
        UIApplication.shared.keyWindow?.make(toast: message)
    }
    
    func getLoginEntity(api: Base, entity: LoginEntity?) {
        
        loader.isHideInMainThread(true)
        if let accessToken = entity?.access_token {
            User.main.accessToken = accessToken
            print(accessToken)
            storeInUserDefaults()
            DispatchQueue.main.async {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.ShiftStatusViewController) {
                    vc.modalPresentationStyle = .fullScreen
                    let navigationController = UINavigationController(rootViewController: vc)
                    self.present(navigationController, animated: true, completion: nil)
                }
                //self.present(Common.setDrawerController(), animated: true, completion: nil)
            }
        }
    }
    
}
