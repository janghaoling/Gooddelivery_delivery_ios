//
//  LiveStatusWithoutAcceptTableViewCell.swift
//  Project
//
//  Created by CSS on 29/01/19.
//  Copyright © 2019 css. All rights reserved.
//

import UIKit

class LiveStatusWithoutAcceptTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewsubHeader: UIView!
    
    @IBOutlet weak var viewHeader : UIView!
    @IBOutlet weak var labelLeftTitle : UILabel!
    @IBOutlet weak var labelTimer : UILabel!
    @IBOutlet weak var imageViewItem : UIImageView!
    @IBOutlet weak var labelItemName : UILabel!
    @IBOutlet weak var labelItemDescription : UILabel!

    
    
    @IBOutlet weak var liveRequestView: UIView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initialLoads()
    }
    
        private func initialLoads() {
            self.localize()
            self.setFonts()
            
            
        }
    
    override func layoutSubviews() {
        liveRequestView.layer.cornerRadius = 8.0
        liveRequestView.layer.shadowColor = UIColor.lightGray.cgColor
        liveRequestView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        liveRequestView.layer.shadowRadius = 4.0
        liveRequestView.layer.shadowOpacity = 0.5
        liveRequestView.clipsToBounds = false
        viewHeader.layer.cornerRadius = 8.0
        imageViewItem.clipsToBounds = true
        imageViewItem.layer.cornerRadius = 4
    }
        
        // Localize
        private func localize() {
            self.labelLeftTitle.text = APPLocalize.localizestring.newOrderRequest.localize()
        }
        
        // Set Font
        private func setFonts() {
            Common.setFont(to: labelLeftTitle, size : 16,fontType : .bold)
            Common.setFont(to: labelTimer)
            Common.setFont(to: labelItemName, size : 16,fontType : .bold)
            Common.setFont(to: labelItemDescription)
        }

    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func SetLiveData(data: OrdersEntity){
        print(data)
        liveRequestView.isHidden = false
        if data.status == "ASSIGNED" {
            viewsubHeader.backgroundColor = UIColor.baseColor
            viewHeader.backgroundColor = UIColor.baseColor
            labelLeftTitle.text = APPLocalize.localizestring.newOrderRequest.localize()

        }else{
            viewsubHeader.backgroundColor = UIColor.onGoingColor
            viewHeader.backgroundColor = UIColor.onGoingColor
            labelLeftTitle.text = APPLocalize.localizestring.ongoingRequest.localize()

        }
        
       
        labelLeftTitle.textColor = UIColor.white
        labelTimer.isHidden = true
        labelItemName.textColor = UIColor.black
        labelItemDescription.textColor = UIColor.descColor
        
        labelItemName.text = data.shop?.name?.uppercased()
        labelItemDescription.text = data.shop?.address
        Cache.image(forUrl: data.shop?.avatar) { (image) in
            DispatchQueue.main.async {
                self.imageViewItem.image = image == nil ? #imageLiteral(resourceName: "userPlaceholder") : image
            }
        }
            }
    
    func SetCompletedData(data: OrdersEntity){

        liveRequestView.isHidden = false
      
        labelLeftTitle.textColor = UIColor.white
        labelTimer.textColor = UIColor.white
        labelItemName.text = data.shop?.name?.uppercased()
        labelItemDescription.text = data.shop?.address
        
        Cache.image(forUrl: data.shop?.avatar) { (image) in
            DispatchQueue.main.async {
                self.imageViewItem.image = image == nil ? #imageLiteral(resourceName: "userPlaceholder") : image
            }
        }
        
       
        let orderIdStr: String! = String(describing: data.id!)
        
        if data.status == "CANCELLED" {
            viewHeader.backgroundColor = UIColor.red
            viewsubHeader.backgroundColor = UIColor.red
            labelLeftTitle.text = "Cancelled #" + orderIdStr!
            labelLeftTitle.textColor = UIColor.white
        }else {
            labelLeftTitle.text = "Delivered #" + orderIdStr!
            labelLeftTitle.textColor = UIColor.completedTaskColor
            viewsubHeader.backgroundColor = UIColor.completedTask

            viewHeader.backgroundColor = UIColor.completedTask
        }
        
        labelTimer.textColor = UIColor.white
        labelLeftTitle.textColor = UIColor.black
        labelItemDescription.textColor = UIColor.descColor
    }
    
}
