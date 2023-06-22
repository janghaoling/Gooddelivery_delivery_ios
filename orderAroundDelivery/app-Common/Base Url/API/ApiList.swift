//
//  ApiList.swift
//  Centros_Camprios
//
//  Created by imac on 12/18/17.
//  Copyright © 2017 Appoets. All rights reserved.
//

import Foundation
import UIKit

//Http Method Types

enum HttpType : String{
    
    case GET = "GET"
    case POST = "POST"
    case PATCH = "PATCH"
    case PUT = "PUT"
    case DELETE = "DELETE"
    
}

// Status Code

enum StatusCode : Int {
    
    case notreachable = 0
    case success = 200
    case multipleResponse = 300
    case unAuthorized = 401
    case notFound = 404
    case ServerError = 500
    
}

enum Base : String{
  
    case login = "/api/transporter/login"
    case verifyOtp = "/api/transporter/verify/otp"
    case logout = "/api/user/logout"
    case profile = "/api/transporter/profile"
    case shift = "/api/transporter/shift"
    case breakTime = "/api/transporter/shift/timing"
    case vehicleList = "/api/transporter/vehicles"
    case liveOrders = "/api/transporter/order"
    case noticeBoard = "api/transporter/notice"
    case startShift = "//api/transporter/shift"
  //case resepwd = "/api/provider/profile/password"
    case distanceMarix = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins="
//    case updateLocation = "api/provider/profile/location"
//    case onlineStatus = "/api/provider/profile/available"
    case orderHistory = "/api/transporter/history"
    case AcceptReject = "/api/transporter/request/order"
    case TransporterRating = "/api/transporter/rating"
    case liveOrderparam = "//api/transporter/order"
    case settings = "/api/user/initsetup"

    init(fromRawValue: String){
        self = Base(rawValue: fromRawValue) ?? .login
    }
    
    static func valueFor(Key : String?)->Base{
        
        guard let key = Key, let base = Base(rawValue: key) else {
            return Base.login
        }
        
//        for val in iterateEnum(Base.self) where val.rawValue == key {
//            return val
//        }
        
        return base
        
    }
    
}



struct APIConstant {
    
    // MARK: - Development Url
    static var baseURL = "https://gooddeliveryiquique.net"

    // MARK: - AppStore Url
    var APP_STORE_URL = ""
}



enum EndPoints: String {
    case orderHistory = "/api/transporter/history"
    case liveOrders = "/api/transporter/order"
    case AcceptReject = "/api/transporter/request/order"

}
