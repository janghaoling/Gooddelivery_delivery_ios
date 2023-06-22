//
//  FeedBackPopViewViewController.swift
//  Project
//
//  Created by CSS on 31/01/19.
//  Copyright © 2019 css. All rights reserved.
//

import UIKit

class FeedBackPopViewViewController: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var feedbacktextView: UITextView!
    @IBOutlet weak var giveFeedbackLabel: UILabel!
    @IBOutlet weak var badLabel: UILabel!
    @IBOutlet weak var okeyLabel: UILabel!
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var superBLabel: UILabel!
    @IBOutlet weak var terribleLabel: UILabel!
    @IBOutlet weak var howWasDeliveryLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var superbImageView: UIImageView!
    @IBOutlet weak var goodImageView: UIImageView!
    @IBOutlet weak var okeyImageView: UIImageView!
    @IBOutlet weak var sadImageView: UIImageView!
    @IBOutlet weak var terribleImageView: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var feedBackOverView: UIView!
    
    var Data: OrdersEntity?
    var feedBackRatingStr = ""
    weak var delegate: FeedBackPopViewViewControllerDelegate?
    private lazy var loader : UIView = {
        return createLottieLoader(in: UIApplication.shared.keyWindow ?? self.view)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initalLoads()
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
        customizeValues()
        setBorder()
        hideKeyboardWhenTappedAround()
        terribleImageView.setRounded()
        superbImageView.setRounded()
        goodImageView.setRounded()
        okeyImageView.setRounded()
        sadImageView.setRounded()
        superBmethod()
    }
    // Custom Values
    private func customizeValues(){
        feedBackOverView.layer.cornerRadius = 10
        submitButton.setTitle(APPLocalize.localizestring.sumbit.localize(), for: .normal)
        submitButton.layer.cornerRadius  = 10
        feedbacktextView.tintColor = UIColor.liveTaskColor
        addToolBarTextView(textView: feedbacktextView)
    }
    
   // Submit Button Action
    @IBAction func onSumbitButtonAction(_ sender: Any) {
        self.loader.isHidden = false
        var transporterRatingRequest = TransporterRatingEntity()
        transporterRatingRequest.order_id = "\(Data!.id!)"
        transporterRatingRequest.comment = feedbacktextView.text
        transporterRatingRequest.rating = feedBackRatingStr
        self.presenter?.post(api: .TransporterRating, data: transporterRatingRequest.toData())
    }
    // Set Font
    private func setFont(){
        submitButton.titleLabel?.font = UIFont.regular(size: 14)
        feedbacktextView.font = UIFont.regular(size: 14)
        giveFeedbackLabel.font = UIFont.bold(size: 14)
        badLabel.font = UIFont.regular(size: 14)
        okeyLabel.font = UIFont.regular(size: 14)
        goodLabel.font = UIFont.regular(size: 14)
        superBLabel.font = UIFont.regular(size: 14)
        terribleLabel.font = UIFont.regular(size: 14)
        howWasDeliveryLabel.font = UIFont.bold(size: 14)
        feedbackLabel.font = UIFont.bold(size: 14)
     
    }
    // Set Color
    private func setColor(){
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.backgroundColor = UIColor.baseColor
        feedbacktextView.textColor = UIColor.black
        giveFeedbackLabel.textColor = UIColor.black
        badLabel.textColor = UIColor.black
        okeyLabel.textColor = UIColor.black
        goodLabel.textColor = UIColor.black
        superBLabel.textColor = UIColor.black
        terribleLabel.textColor = UIColor.black
        howWasDeliveryLabel.textColor = UIColor.black
        feedbackLabel.textColor = UIColor.black
        topView.backgroundColor = UIColor.baseColor
        
        
    }
    // Set Border
    func setBorder()
    {
        feedbacktextView.layer.borderColor = UIColor.lightGray.cgColor
        feedbacktextView.layer.borderWidth = 1
    }
    
    
    @IBAction func onTerribleAction(_ sender: Any) {
        terribleImageView.backgroundColor = UIColor.baseColor
        terribleImageView.tintColor = UIColor.black
        terribleImageView.image = terribleImageView.image!.withRenderingMode(.alwaysTemplate)
        
        sadImageView.image = sadImageView.image!.withRenderingMode(.alwaysOriginal)
        okeyImageView.image = okeyImageView.image!.withRenderingMode(.alwaysOriginal)
        goodImageView.image = goodImageView.image!.withRenderingMode(.alwaysOriginal)
        superbImageView.image = superbImageView.image!.withRenderingMode(.alwaysOriginal)
        
        sadImageView.backgroundColor = UIColor.white
        okeyImageView.backgroundColor = UIColor.white
        goodImageView.backgroundColor = UIColor.white
        superbImageView.backgroundColor = UIColor.white
        
        feedBackRatingStr = "1"
    }
    
    @IBAction func onSadAction(_ sender: Any) {
        sadImageView.backgroundColor = UIColor.baseColor
        sadImageView.tintColor = UIColor.black
        sadImageView.image = sadImageView.image!.withRenderingMode(.alwaysTemplate)
        
        terribleImageView.image = terribleImageView.image!.withRenderingMode(.alwaysOriginal)
        okeyImageView.image = okeyImageView.image!.withRenderingMode(.alwaysOriginal)
        goodImageView.image = goodImageView.image!.withRenderingMode(.alwaysOriginal)
        superbImageView.image = superbImageView.image!.withRenderingMode(.alwaysOriginal)
        
        terribleImageView.backgroundColor = UIColor.white
        okeyImageView.backgroundColor = UIColor.white
        goodImageView.backgroundColor = UIColor.white
        superbImageView.backgroundColor = UIColor.white
        
        feedBackRatingStr = "2"
    }
    
    @IBAction func onOkeyAction(_ sender: Any) {
        okeyImageView.backgroundColor = UIColor.baseColor
        okeyImageView.tintColor = UIColor.black
        okeyImageView.image = okeyImageView.image!.withRenderingMode(.alwaysTemplate)
        
        terribleImageView.image = terribleImageView.image!.withRenderingMode(.alwaysOriginal)
        sadImageView.image = sadImageView.image!.withRenderingMode(.alwaysOriginal)
        goodImageView.image = goodImageView.image!.withRenderingMode(.alwaysOriginal)
        superbImageView.image = superbImageView.image!.withRenderingMode(.alwaysOriginal)
        
        terribleImageView.backgroundColor = UIColor.white
        sadImageView.backgroundColor = UIColor.white
        goodImageView.backgroundColor = UIColor.white
        superbImageView.backgroundColor = UIColor.white
        
        feedBackRatingStr = "3"
    }
    
    @IBAction func onGoodAction(_ sender: Any) {
        goodImageView.backgroundColor = UIColor.baseColor
        goodImageView.tintColor = UIColor.black
        goodImageView.image = goodImageView.image!.withRenderingMode(.alwaysTemplate)
        
        terribleImageView.image = terribleImageView.image!.withRenderingMode(.alwaysOriginal)
        sadImageView.image = sadImageView.image!.withRenderingMode(.alwaysOriginal)
        superbImageView.image = superbImageView.image!.withRenderingMode(.alwaysOriginal)
        okeyImageView.image = okeyImageView.image!.withRenderingMode(.alwaysOriginal)
        
        terribleImageView.backgroundColor = UIColor.white
        sadImageView.backgroundColor = UIColor.white
        okeyImageView.backgroundColor = UIColor.white
        superbImageView.backgroundColor = UIColor.white
        
        feedBackRatingStr = "4"
    }
    
    @IBAction func onSuperBAction(_ sender: Any) {
        superBmethod()
    }
    
    
    func superBmethod() {
        superbImageView.backgroundColor = UIColor.baseColor
        superbImageView.tintColor = UIColor.black
        superbImageView.image = superbImageView.image!.withRenderingMode(.alwaysTemplate)
        
        terribleImageView.image = terribleImageView.image!.withRenderingMode(.alwaysOriginal)
        sadImageView.image = sadImageView.image!.withRenderingMode(.alwaysOriginal)
        goodImageView.image = goodImageView.image!.withRenderingMode(.alwaysOriginal)
        okeyImageView.image = okeyImageView.image!.withRenderingMode(.alwaysOriginal)
        
        terribleImageView.backgroundColor = UIColor.white
        sadImageView.backgroundColor = UIColor.white
        okeyImageView.backgroundColor = UIColor.white
        goodImageView.backgroundColor = UIColor.white
        
        feedBackRatingStr = "5"
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
extension FeedBackPopViewViewController: PostViewProtocol {
    func onError(api: Base, message: String, statusCode code: Int) {
        self.loader.isHidden = true
        self.loader.isHideInMainThread(true)
        
    }
    func getTransporterRating(api: Base, entity: TransporterRatingEntity?) {
        self.loader.isHidden = true
        self.loader.isHideInMainThread(true)
        dismiss(animated: true, completion: nil)
        delegate?.FeedBackNextScreen()

    }
    
    
}
// MARK: - Protocol
protocol FeedBackPopViewViewControllerDelegate: class {
    func FeedBackNextScreen()
}
