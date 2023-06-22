//
//  OrderModelEntity.swift
//  Project
//
//  Created by CSS on 01/02/19.
//  Copyright © 2019 css. All rights reserved.
//

import Foundation


struct OrderModelEntity : JSONSerializable {
    
    var id : Int?
    var invoice_id : String?
    var user_id : Int?
    var shift_id : Int?
    var user_address_id : Int?
    var shop_id : Int?
    var transporter_id : Int?
    var transporter_vehicle_id : Int?
    var reason : String?
    var note : String?
    var route_key : String?
    var dispute : String?
    var delivery_date : String?
    var order_otp : Int?
    var order_ready_time : Int?
    var order_ready_status : Int?
    var status : String?
    var schedule_status : Int?
    var created_at : String?
    var response_time : Int?
    var dispute_manager : [Dispute_manager]?
    var user : User?
    var transporter : Transporter?
    var vehicles : Vehicles?
    var invoice : Invoice?
    var address : OrderAddress?
    var shop : Shop?
    var items : [Items]?
    var ordertiming : [Ordertiming]?
    var disputes : [Disputes]?
    var reviewrating : Reviewrating?
    var total_pay: String?
    var tender_pay: String?
    var payment_mode: String?
    var payment_status: String?
}
