//
//  Interactor.swift
//  User
//
//  Created by imac on 12/19/17.
//  Copyright © 2017 Appoets. All rights reserved.
//

import Foundation

class Interactor  {
    
    var webService: PostWebServiceProtocol?
    
    var presenter: PostPresenterOutputProtocol?
    
}

//MARK:- PostInteractorInputProtocol

extension Interactor : PostInteractorInputProtocol {
    
    func send(api: Base, imageData: [String : Data]?, data: Data?) {
        webService?.retrieve(api: api,url: nil, data: data, imageData: imageData, type: .POST, completion: nil)
    }
    func send(api: Base, url: String, data: Data?, type: HttpType) {
        webService?.retrieve(api: api,url: url, data: data, imageData: nil, type: type, completion: nil)
    }
    func send(api: Base, data: Data?, type: HttpType) {
        webService?.retrieve(api: api, url: nil, data: data, imageData: nil, type: type, completion: nil)
    }
    
}


extension Interactor : PostInteractorOutputProtocol {

    func on(api: Base, response: Data) {
        
        switch api {
        case .login, .verifyOtp:
            self.presenter?.sendLoginEntity(api: api, data: response)
        case .profile:
            self.presenter?.sendProfile(api: api, data: response)
        case .shift, .startShift, .breakTime:
            self.presenter?.sendShiftStatus(api: api, data: response)
        case .vehicleList:
            self.presenter?.sendVehicleEntityList(api: api, data: response)
        case .noticeBoard:
            self.presenter?.sendNoticeEntityList(api: api, data: response)
        case .liveOrders:
            self.presenter?.sendLiveOrdersRequestEntity(api: api, data: response)
        case .orderHistory:
            self.presenter?.sendOrderHistoryList(api: api, data: response)
        case .AcceptReject:
            self.presenter?.sendAcceptReject(api: api, data: response)
        case .TransporterRating:
            self.presenter?.sendTransporterRating(api: api, data: response)
        case .liveOrderparam:
            self.presenter?.sendLiveOrderParam(api: api, data: response)
        case .logout:
            self.presenter?.sendLogoutEntity(api: api, data: response)
        case .settings :
            self.presenter?.sendSettingsData(api: api, data: response)
        default :
            break
            
        }
    }
    
    func on(api: Base, error: CustomError) {
        
        presenter?.onError(api: api, error: error)
        
    }
    
    
}

