//
//  ShiftStatusTableViewCell.swift
//  Project
//
//  Created by CSS on 18/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import UIKit

class ShiftStatusTableViewCell: UITableViewCell {
    
    @IBOutlet private var imageViewStatus : UIImageView!
    @IBOutlet private weak var labelOrders : UILabel!
    @IBOutlet private weak var labelBreakCount : UILabel!
    @IBOutlet private weak var labelBreakTime : Label!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.drawDottedLine(start: CGPoint(x: self.imageViewStatus.frame.origin.x+self.imageViewStatus.frame.width/2, y: 0), end : CGPoint(x: self.imageViewStatus.frame.origin.x+self.imageViewStatus.frame.width/2, y: self.imageViewStatus.frame.origin.y-8), view: self, lineColor: .gray)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK:-  Methods
extension ShiftStatusTableViewCell {
    
    private func setFont() {
        Common.setFont(to: labelOrders, size: 12)
        Common.setFont(to: labelBreakTime, size: 10)
        Common.setFont(to: labelBreakCount, size : 16)
    }
    
    
    // Setting Values
    
    func set(value : ShiftDetail, orderCount : Int, breakCount : String, isShifEnded : Bool = false) {
        self.labelOrders.text =  orderCount == 0 ? APPLocalize.localizestring.noOrders.localize() :"\(orderCount) \((orderCount>1 ? APPLocalize.localizestring.orders.localize():APPLocalize.localizestring.order.localize()).localize())"
        let startDateObject = Formatter.shared.getDate(from: value.start_time, format: DateFormat.list.yyyy_mm_dd_HH_MM_ss)
        let startDateString = Formatter.shared.getString(from: startDateObject, format: DateFormat.list.hh_mm_a)
        let endDateObject = Formatter.shared.getDate(from: value.end_time, format: DateFormat.list.yyyy_mm_dd_HH_MM_ss)
        let endDateString = Formatter.shared.getString(from: endDateObject, format: DateFormat.list.hh_mm_a)
        self.labelBreakTime.text = { //  Setting Break Time
            if (!startDateString.isEmpty && !endDateString.isEmpty) {
                return "\(startDateString) - \(endDateString)"
            } else if !startDateString.isEmpty {
                return startDateString
            } else if !endDateString.isEmpty {
                return endDateString
            }
            return .Empty
        }()
        self.labelBreakCount.text = breakCount
        self.imageViewStatus.image = UIImage(named: isShifEnded ? "logout" : "pause")
    }
    
}
