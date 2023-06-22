//
//  OrdersEntity.swift
//  Project
//
//  Created by infos on 10/31/18.
//  Copyright © 2018 css. All rights reserved.
//

import Foundation

struct OrdersEntity : Codable, JSONSerializable {
    
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
    var safe_delivery : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case invoice_id = "invoice_id"
        case user_id = "user_id"
        case shift_id = "shift_id"
        case user_address_id = "user_address_id"
        case shop_id = "shop_id"
        case transporter_id = "transporter_id"
        case transporter_vehicle_id = "transporter_vehicle_id"
        case reason = "reason"
        case note = "note"
        case route_key = "route_key"
        case dispute = "dispute"
        case delivery_date = "delivery_date"
        case order_otp = "order_otp"
        case order_ready_time = "order_ready_time"
        case order_ready_status = "order_ready_status"
        case status = "status"
        case schedule_status = "schedule_status"
        case created_at = "created_at"
        case response_time = "response_time"
        case dispute_manager = "dispute_manager"
        case user = "user"
        case transporter = "transporter"
        case vehicles = "vehicles"
        case invoice = "invoice"
        case address = "address"
        case shop = "shop"
        case items = "items"
        case ordertiming = "ordertiming"
        case disputes = "disputes"
        case reviewrating = "reviewrating"
        case safe_delivery = "safe_delivery"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        invoice_id = try values.decodeIfPresent(String.self, forKey: .invoice_id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        shift_id = try values.decodeIfPresent(Int.self, forKey: .shift_id)
        user_address_id = try values.decodeIfPresent(Int.self, forKey: .user_address_id)
        shop_id = try values.decodeIfPresent(Int.self, forKey: .shop_id)
        transporter_id = try values.decodeIfPresent(Int.self, forKey: .transporter_id)
        transporter_vehicle_id = try values.decodeIfPresent(Int.self, forKey: .transporter_vehicle_id)
        safe_delivery = try values.decodeIfPresent(Int.self, forKey: .safe_delivery)
        reason = try values.decodeIfPresent(String.self, forKey: .reason)
        note = try values.decodeIfPresent(String.self, forKey: .note)
        route_key = try values.decodeIfPresent(String.self, forKey: .route_key)
        dispute = try values.decodeIfPresent(String.self, forKey: .dispute)
        delivery_date = try values.decodeIfPresent(String.self, forKey: .delivery_date)
        order_otp = try values.decodeIfPresent(Int.self, forKey: .order_otp)
        order_ready_time = try values.decodeIfPresent(Int.self, forKey: .order_ready_time)
        order_ready_status = try values.decodeIfPresent(Int.self, forKey: .order_ready_status)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        schedule_status = try values.decodeIfPresent(Int.self, forKey: .schedule_status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        response_time = try values.decodeIfPresent(Int.self, forKey: .response_time)
        dispute_manager = try values.decodeIfPresent([Dispute_manager].self, forKey: .dispute_manager)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        transporter = try values.decodeIfPresent(Transporter.self, forKey: .transporter)
        vehicles = try values.decodeIfPresent(Vehicles.self, forKey: .vehicles)
        invoice = try values.decodeIfPresent(Invoice.self, forKey: .invoice)
        address = try values.decodeIfPresent(OrderAddress.self, forKey: .address)
        shop = try values.decodeIfPresent(Shop.self, forKey: .shop)
        items = try values.decodeIfPresent([Items].self, forKey: .items)
        ordertiming = try values.decodeIfPresent([Ordertiming].self, forKey: .ordertiming)
        disputes = try values.decodeIfPresent([Disputes].self, forKey: .disputes)
        reviewrating = try values.decodeIfPresent(Reviewrating.self, forKey: .reviewrating)
    }
    
}
