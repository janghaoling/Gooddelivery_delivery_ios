//
//  OrderHistoryTableViewCell.swift
//  Project
//
//  Created by CSS on 24/01/19.
//  Copyright © 2019 css. All rights reserved.
//

import UIKit
class OrderHistoryTableViewCell: UITableViewCell {
    @IBOutlet private weak var restaurantImageView : UIImageView!
    @IBOutlet weak var backgroundOverView: UIView!
    @IBOutlet private weak var restaurantNameLabel : UILabel!
    @IBOutlet private weak var orderNumberLabel : UILabel!
    @IBOutlet private weak var orderStatusLabel : UILabel!
    @IBOutlet private weak var orderTimeLabel : UILabel!
    @IBOutlet private weak var noOfItemLabel : UILabel!
    @IBOutlet private weak var priceLabel : UILabel!
    @IBOutlet private weak var orderStatusView : UIView!
    @IBOutlet private weak var overView : UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initalLoads()
    }
    private func initalLoads() {
        setInitalFont()
        overViewShadow()
        commonValues()
    }
    override func layoutSubviews() {
        orderStatusView.layer.cornerRadius = 12
        restaurantImageView.layer.cornerRadius = 8
        restaurantImageView.clipsToBounds = true
    }
        
    private func commonValues(){
       
        orderStatusView.backgroundColor = UIColor.primary
        backgroundOverView.backgroundColor = UIColor.primary
    }
    private func overViewShadow(){
        overView.layer.cornerRadius = 5.0
        overView.layer.shadowColor = UIColor.lightGray.cgColor
        overView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        overView.layer.shadowRadius = 4.0
        overView.layer.shadowOpacity = 0.5
    }
    
    private func setInitalFont(){
       restaurantNameLabel.font = UIFont.bold(size: 14)
        orderNumberLabel.font = UIFont.regular(size: 15)
        noOfItemLabel.font = UIFont.regular(size: 12)
        priceLabel.font = UIFont.regular(size: 12)
        orderTimeLabel.font = UIFont.regular(size: 12)
        orderStatusLabel.font = UIFont.regular(size: 12)
    }
    
    func setupData(data: OrdersEntity) {
        restaurantNameLabel.text = data.shop?.name?.uppercased()
        let orderIdStr: String! = String(describing: data.id!)
        orderNumberLabel.text = "#" + orderIdStr
        let noOfItemsStr: String! = String(describing: data.items!.count)
        noOfItemLabel.text = noOfItemsStr
        let priceStr: String! = String(describing: data.invoice!.net!)
        let priceval = "$" + priceStr
        priceLabel.text = priceval
        let date = convertDateFormater(data.created_at ?? "")
        orderTimeLabel.text = date
        orderStatusLabel.text = data.status
        Cache.image(forUrl: data.shop?.avatar) { (image) in
            DispatchQueue.main.async {
                self.restaurantImageView.image = image == nil ? #imageLiteral(resourceName: "userPlaceholder") : image
            }
        }
    }
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "hh:mm a"
        return  dateFormatter.string(from: date!)
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
