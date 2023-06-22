//
//  LiveStatusTableViewCell.swift
//  Project
//
//  Created by CSS on 23/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import UIKit

protocol LiveStatusTableViewCellDelegate: class {
    func onCallAcceptReject(requestStatus: String)
}

class LiveStatusTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewSubHeader: UIView!
    @IBOutlet weak var waitingImage: UIImageView!
    @IBOutlet weak var waitingLabel: UILabel!
    @IBOutlet weak var waitingView: UIView!
    @IBOutlet weak var viewHeader : UIView!
    @IBOutlet weak var labelLeftTitle : UILabel!
    @IBOutlet weak var labelTimer : UILabel!
    @IBOutlet weak var imageViewItem : UIImageView!
    @IBOutlet weak var labelItemName : UILabel!
    @IBOutlet weak var labelItemDescription : UILabel!
    @IBOutlet weak var viewActions : UIStackView!
    @IBOutlet weak var buttonAccept : UIButton!
    @IBOutlet weak var buttonCancel : UIButton!
    @IBOutlet weak var BtnResponseView: UIStackView!
    @IBOutlet weak var liveRequestView: UIView!
    weak var delegate: LiveStatusTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialLoads()
    }
    
    override func layoutSubviews() {
        liveRequestView.layer.cornerRadius = 8.0
        liveRequestView.layer.shadowColor = UIColor.lightGray.cgColor
        liveRequestView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        liveRequestView.layer.shadowRadius = 4.0
        liveRequestView.layer.shadowOpacity = 0.5
        liveRequestView.clipsToBounds = false
        viewHeader.layer.cornerRadius = 8.0
        BtnResponseView.layer.cornerRadius = 8.0
    }
    @IBAction func AcceptButtonAction(_ sender: Any) {
        delegate?.onCallAcceptReject(requestStatus: "ACCEPT")
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        delegate?.onCallAcceptReject(requestStatus: "REJECT")
    }

}

extension LiveStatusTableViewCell  {
    
    private func initialLoads() {
        self.localize()
        self.setFonts()
    }
    
    
    
    // Localize
    private func localize() {
        self.labelLeftTitle.text = APPLocalize.localizestring.newOrderRequest.localize()
        self.buttonAccept.setTitle(APPLocalize.localizestring.accept.localize(), for: .normal)
        self.buttonCancel.setTitle(APPLocalize.localizestring.Cancel.localize(), for: .normal)
    }
    
    // Set Font
    private func setFonts() {
        Common.setFont(to: labelLeftTitle, size : 16,fontType : .bold)
        Common.setFont(to: labelTimer)
        Common.setFont(to: labelItemName, size : 16,fontType : .bold)
        Common.setFont(to: labelItemDescription)
        Common.setFont(to: buttonCancel, isTitle: true, fontType : .bold)
        Common.setFont(to: buttonAccept, isTitle: true, fontType : .bold)
    }
    
   //MARK: set values for live Request
    func setValueLiveOrderData(values: OrdersEntity){
        waitingView.isHidden = false
        liveRequestView.isHidden = true
        if values.transporter?.status == "unsettled" {
            waitingImage.image = UIImage(named: ImageString.imageValue.handOverCash)
            waitingLabel.text = "Please settle the Amount to the respective restaurant".uppercased()
            waitingLabel.font = UIFont.regular(size: 14)
        }else if values.transporter?.status == "offline" {
            waitingImage.image = UIImage(named: ImageString.imageValue.purchase)
            waitingLabel.text = "Turn on Start Shift to go for delivery"
            waitingLabel.font = UIFont.regular(size: 14)
            
        }else{
            waitingImage.image = UIImage(named: ImageString.imageValue.hourglass)
            waitingLabel.text = APPLocalize.localizestring.waitingNewTask.localize()
            waitingLabel.font = UIFont.regular(size: 16)
            
        }
    } 
    
    
    
    func commonFont(){
        labelTimer.textColor = UIColor.white
        buttonAccept.titleLabel?.font = UIFont.bold(size: 16)
        buttonCancel.titleLabel?.font = UIFont.bold(size: 16)
        buttonAccept.setTitleColor(UIColor.white, for: .normal)
        buttonCancel.setTitleColor(UIColor.white, for: .normal)
        buttonCancel.backgroundColor = UIColor.red
        buttonAccept.backgroundColor = UIColor.acceptColor
    }
    
    
    func setLiveData(data: OrdersEntity){
        buttonAccept.isHidden = false
        buttonCancel.isHidden = false
        liveRequestView.isHidden = false
        viewSubHeader.backgroundColor = UIColor.liveTaskColor
        viewHeader.backgroundColor = UIColor.liveTaskColor
        imageViewItem.clipsToBounds = true
        imageViewItem.layer.cornerRadius = 4
        labelLeftTitle.text = APPLocalize.localizestring.newOrderRequest.localize()
        labelLeftTitle.textColor = UIColor.white
        labelTimer.isHidden = true
        imageViewItem.layer.cornerRadius = 4
        labelItemName.textColor = UIColor.black
        labelItemDescription.textColor = UIColor.descColor
        
        labelItemName.text = data.shop?.name?.capitalized
        labelItemDescription.text = data.shop?.address
        
        Cache.image(forUrl: data.shop?.avatar) { (image) in
            DispatchQueue.main.async {
                self.imageViewItem.image = image == nil ? #imageLiteral(resourceName: "userPlaceholder") : image
            }
        }
        viewSubHeader.backgroundColor = UIColor.baseColor
        viewHeader.backgroundColor = UIColor.baseColor
        
       // labelTimer.text = responseTimeStr
        
        
    }
}
