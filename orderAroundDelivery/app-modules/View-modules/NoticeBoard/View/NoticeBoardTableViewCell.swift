


//
//  NoticeBoardTableViewCell.swift
//  Project
//
//  Created by CSS on 30/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import UIKit

class NoticeBoardTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var labelTitle : UILabel!
    @IBOutlet private weak var labelTime : UILabel!
    @IBOutlet private weak var labelNotice : UILabel!
    @IBOutlet private weak var labelNote : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialLoads()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


extension NoticeBoardTableViewCell {
    
    private func initialLoads() {
        self.setFont()
    }
    
    private func setFont() {
        Common.setFont(to: labelTitle, size: 18, fontType : .bold)
        Common.setFont(to: labelTime)
        Common.setFont(to: labelNote)
        Common.setFont(to: labelNotice)
        self.labelNote.textColor = UIColor.red
    }
    
    func set(value : NoticeBoardEntity) {
        self.labelTitle.text = value.title
        let dateObject = Formatter.shared.getDate(from: value.created_at, format: DateFormat.list.yyyy_mm_dd_HH_MM_ss)
        let dateString = Formatter.shared.getString(from: dateObject, format: DateFormat.list.MMM_dd_yyyy)
        self.labelTime.text = dateString
        self.labelNotice.text = value.notice
        self.labelNote.text = value.note
    }
    
}
