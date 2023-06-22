//
//  ProfileViewController.swift
//  Project
//
//  Created by CSS on 30/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet private weak var imageViewProfile : UIImageView!
    @IBOutlet private weak var viewEditImage : UIView!
    @IBOutlet private weak var textFieldUserName : UITextField!
    @IBOutlet private weak var textFieldUserId : UITextField!
    @IBOutlet private weak var textFieldPhoneNumber : UITextField!
    @IBOutlet private weak var textFieldEmail : UITextField!
   // @IBOutlet private weak var viewHeader : UIView!
    @IBOutlet private weak var buttonUpdate : UIButton!
    private var modifiedImage : UIImage?
    private lazy var loader : UIView = {
        return createLottieLoader(in: UIApplication.shared.keyWindow ?? self.view)
    }()
    
override func viewDidLoad() {
    super.viewDidLoad()
    self.initalLoads()
    
}

override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.layouts()
}
    
    
    override func viewWillAppear(_ animated: Bool) {
        enableKeyboardHandling()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        disableKeyboardHandling()
    }
    
    

}

extension ProfileViewController : UIViewStructure {
    
    func initalLoads() {
        self.localize()
        self.design()
        self.setValues()
        addAction()
        self.hideKeyboardWhenTappedAround()
    }

    func addAction(){
        self.viewEditImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.changeImage)))
        self.buttonUpdate.addTarget(self, action: #selector(self.update), for:  .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: ImageString.imageValue.backicon), style: .done, target: self, action: #selector(self.backButtonClick))
    }
  
    
    func localize() {
        self.userIdLabel.text = APPLocalize.localizestring.userId.localize().uppercased()
        self.userNameLabel.text = APPLocalize.localizestring.userName.localize().uppercased()
        self.userEmailLabel.text = APPLocalize.localizestring.email.localize().uppercased()
        self.userPhoneLabel.text = APPLocalize.localizestring.phoneNumber.localize().uppercased()
        self.buttonUpdate.setTitle(APPLocalize.localizestring.update.localize().uppercased(), for: .normal)
        self.navigationItem.title = APPLocalize.localizestring.profile.localize()
    }
    
    func design() {
        Common.setFont(to: textFieldUserId, size : 16)
        Common.setFont(to: textFieldUserName, size : 16)
        Common.setFont(to: textFieldEmail, size : 16)
        Common.setFont(to: textFieldPhoneNumber, size : 16)
        Common.setFont(to: buttonUpdate, size : 16)
        userIdLabel.font = UIFont.regular(size: 14)
        userNameLabel.font = UIFont.regular(size: 14)
        userEmailLabel.font = UIFont.regular(size: 14)
        userPhoneLabel.font = UIFont.regular(size: 14)

        textFieldUserId.textColor = .primary
        textFieldUserName.textColor = .primary
        textFieldEmail.textColor = .primary
        textFieldPhoneNumber.textColor = .primary
        
        textFieldEmail.tintColor = UIColor.primary
        textFieldUserId.tintColor = UIColor.primary
        textFieldUserName.tintColor = UIColor.primary
        textFieldPhoneNumber.tintColor = UIColor.primary
        
        buttonUpdate.setTitleColor(.white, for: .normal)
        
        self.textFieldUserId.isEnabled = false
        self.textFieldPhoneNumber.isEnabled = false
    }
    
    func layouts() {
       self.imageViewProfile.makeRoundedCorner()
    }
    
    private func setValues() {
        self.imageViewProfile.setImage(with: User.main.avatar, placeHolder: #imageLiteral(resourceName: "userPlaceholder"))
        self.textFieldUserName.text = User.main.name
        self.textFieldUserId.text = User.main.id?.toString()
        self.textFieldEmail.text = User.main.email
        self.textFieldPhoneNumber.text = User.main.phone
    }
    
    @IBAction private func update() {
        
        guard let name = textFieldUserName.text, !name.isEmpty else {
            UIApplication.shared.keyWindow?.make(toast: APPLocalize.localizestring.enterName.localize())
            return
        }
        
        guard let email = textFieldEmail.text, !email.isEmpty else {
            UIApplication.shared.keyWindow?.make(toast: APPLocalize.localizestring.enterEmail.localize())
            return
        }
        self.loader.isHidden = false
        var request = Profile()
        request.name = name
        request.email = email
        if self.modifiedImage != nil, let imageData = self.modifiedImage!.pngData() {
            self.presenter?.post(api: .profile, imageData: [WebConstants.string.avatar:imageData], data: request.toData())
        }else {
            self.presenter?.post(api: .profile, data: request.toData())
        }
        
    }
    
    // MARK:- Tap Gesture Change Image
    
    @IBAction private func changeImage() {
        showImage { (image) in
            if image != nil {
                  let imageObject = image?.resizeImage(newWidth: 100)
                  self.modifiedImage = imageObject
                  self.imageViewProfile.image = imageObject
            }
        }
    }
    
}

extension ProfileViewController : PostViewProtocol {
    
    func onError(api: Base, message: String, statusCode code: Int) {
        DispatchQueue.main.async {
            self.loader.isHidden = true
            UIApplication.shared.keyWindow?.makeToast(message)
        }
    }
    func getProfile(api: Base, entity: Profile?) {
        if entity != nil {
            Common.setProfile(detail: entity!)
            storeInUserDefaults()
            self.setValues()
        }
        
        DispatchQueue.main.async {
            if !self.loader.isHidden {
                self.loader.isHidden = true
                UIApplication.shared.keyWindow?.make(toast: APPLocalize.localizestring.updatedSuccessfully.localize(), duration: 2, completion: {[weak self] in
                    UIApplication.shared.keyWindow?.hideAllToasts()
                    self?.popOrDismiss(animation: true)
                })
            }
        }
    }
}
extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true

    }
}
