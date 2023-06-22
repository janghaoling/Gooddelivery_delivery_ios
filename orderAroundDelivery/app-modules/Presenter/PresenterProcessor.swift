//
//  PresenterProcessor.swift
//  User
//
//  Created by imac on 1/1/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import Foundation

class PresenterProcessor {
    
    
    static let shared = PresenterProcessor()
    
    func success(api : Base, response : Data)->String{
        return .Empty
    }
    
    func loginEntity(api : Base, response : Data)->LoginEntity? {
        return response.getDecodedObject(from: LoginEntity.self)
    }
    
    func profileEntity(api : Base, response : Data)->Profile? {
        return response.getDecodedObject(from: Profile.self)
    }
    
    func shiftDetailEntity(api : Base, response : Data)->[ShiftDetail] {
        return response.getDecodedObject(from: [ShiftDetail].self) ?? []
    }
    
    func vehicleEntityList(api : Base, response : Data)->[VehicleEntity] {
        return response.getDecodedObject(from: [VehicleEntity].self) ?? []
    }
    
    func noticeBoardList(api : Base, response : Data)->[NoticeBoardEntity] {
        return response.getDecodedObject(from: [NoticeBoardEntity].self) ?? []
    }
    
    func ordersEntity(api: Base, response :Data )->[OrdersEntity] {
        
        return response.getDecodedObject(from: [OrdersEntity].self) ?? []
    }
    
    func ordersModelEntity(api: Base, response :Data )->OrderModelEntity? {
        
        return response.getDecodedObject(from: OrderModelEntity.self)
    }
    
    func AcceptRejectEntity(api : Base, response : Data)->AcceptRejectModel? {
        return response.getDecodedObject(from: AcceptRejectModel.self)
    }
    
    func transporterRatingEntity(api : Base, response : Data)->TransporterRatingEntity? {
        return response.getDecodedObject(from: TransporterRatingEntity.self)
    }
    
    func logoutEntity(api : Base, response : Data)->LogoutEntity? {
        return response.getDecodedObject(from: LogoutEntity.self)
    }
    func getSettingsData(data: Data)-> SettingsEntity? {
        
        return data.getDecodedObject(from: SettingsEntity.self)
    }
//    func signUpAuth(data: Data)-> SignUpMdel?{
//        
//        
//        return data.getDecodedObject(from: SignUpMdel.self)
//    }
//
//    func login(data: Data)-> loginModel? {
//        
//        return data.getDecodedObject(from: loginModel.self)!
//    }
//    
//    
//    func resetPassword(data: Data)-> resetPasswordModel? {
//        
//        return data.getDecodedObject(from: resetPasswordModel.self)!
//    }
//    
//    
//    func updateLocation(data: Data)-> updateLocationModel{
//        
//        return data.getDecodedObject(from: updateLocationModel.self)!
//    }
//    
//    func  OnlineStatus(data: Data)-> OnlinestatusModelResponse {
//        
//        return data.getDecodedObject(from: OnlinestatusModelResponse.self)!
//    }
    
}






