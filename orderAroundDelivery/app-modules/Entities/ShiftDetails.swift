//
//  ShiftDetails.swift
//  Project
//
//  Created by CSS on 26/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import Foundation

class ShiftDetail: JSONSerializable {
    var id : Int?
    var end_time : String?
    var start_time : String?
    var total_amount : Float?
    var total_amount_pay : Float?
    var total_order : Int?
    var order_count : Int?
    var shiftbreaktimes : [ShiftDetail]?
}
