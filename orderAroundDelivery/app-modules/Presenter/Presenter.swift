//
//  Presenter.swift
//  User
//
//  Created by imac on 12/19/17.
//  Copyright © 2017 Appoets. All rights reserved.
//

import Foundation


class Presenter  {
    
    var interactor: PostInteractorInputProtocol?
    var controller: PostViewProtocol?
}

//MARK:- Implementation PostPresenterInputProtocol

extension Presenter : PostPresenterInputProtocol {
    
    func put(api: Base, url: String, data: Data?) {
        interactor?.send(api: api, url: url, data: data, type: .PUT)
    }
    
    func delete(api: Base, url: String, data: Data?) {
        interactor?.send(api: api, url: url, data: data, type: .DELETE)
    }
    
    func patch(api: Base, url: String, data: Data?) {
        interactor?.send(api: api, url: url, data: data,type: .PATCH)
    }
    
    func post(api: Base, data: Data?) {
        interactor?.send(api: api, data: data, type: .POST)
    }
    
    func get(api: Base, data : Data?) {
        interactor?.send(api: api, data: data, type: .GET)
    }
    
    func get(api : Base, url : String){
        interactor?.send(api: api, url: url, data: nil, type: .GET)
    }
    
    func post(api: Base, imageData: [String : Data]?, data : Data?) {
        interactor?.send(api: api, imageData: imageData, data : data)
    }
    
    func post(api: Base, url: String, data: Data?) {
        interactor?.send(api: api, url: url, data: data,type: .POST)
    }
    
}


//MARK:- Implementation PostPresenterOutputProtocol

extension Presenter : PostPresenterOutputProtocol {
    func sendLiveOrderParam(api: Base, data: Data) {
        controller?.getLiveOrderParam(api: api, entity: PresenterProcessor.shared.ordersModelEntity(api: api, response: data)!)

    }
    func onError(api: Base, error: CustomError) {
        controller?.onError(api: api, message: error.localizedDescription, statusCode: error.statusCode)
    }
    
    func sendLoginEntity(api: Base, data: Data) {
        controller?.getLoginEntity(api: api, entity: PresenterProcessor.shared.loginEntity(api: api, response: data))
    }
    
    func sendProfile(api: Base, data: Data) {
        controller?.getProfile(api: api, entity: PresenterProcessor.shared.profileEntity(api: api, response: data))
    }
    func sendShiftStatus(api: Base, data: Data) {
        controller?.getShiftStatusArray(api: api, entity: PresenterProcessor.shared.shiftDetailEntity(api: api, response: data))
    }
    func sendVehicleEntityList(api: Base, data: Data) {
        controller?.getVehicleEntityList(api: api, entity: PresenterProcessor.shared.vehicleEntityList(api: api, response: data))
    }
    func sendNoticeEntityList(api: Base, data: Data) {
        controller?.getNoticeEntityList(api: api, entity: PresenterProcessor.shared.noticeBoardList(api: api, response: data))
    }
    
    func sendLiveOrdersRequestEntity(api: Base, data: Data) {
        controller?.getLiveOrderRequest(api: api, entity: PresenterProcessor.shared.ordersEntity(api: api, response: data))
    }
    
    func sendOrderHistoryList(api: Base, data: Data) {
        controller?.getOrderHistory(api: api, entity: PresenterProcessor.shared.ordersEntity(api: api, response: data))
    }
    
    func sendAcceptReject(api: Base, data: Data) {
        controller?.getAcceptReject(api: api, entity: PresenterProcessor.shared.AcceptRejectEntity(api: api, response: data))
    }
    
    func sendTransporterRating(api: Base, data: Data) {
        controller?.getTransporterRating(api: api, entity: PresenterProcessor.shared.transporterRatingEntity(api: api, response: data))
    }
    func sendLogoutEntity(api: Base, data: Data) {
        controller?.getLogoutEntity(api: api, entity: PresenterProcessor.shared.logoutEntity(api: api, response: data))
    }
    func sendSettingsData(api: Base, data: Data) {
        controller?.getSettingsData(api: api, data: PresenterProcessor.shared.getSettingsData(data: data))
    }
    
}


