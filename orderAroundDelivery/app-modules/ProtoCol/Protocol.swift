//
//  Protocol.swift
//  Centros_Camprios
//
//  Created by imac on 12/18/17.
//  Copyright © 2017 Appoets. All rights reserved.
//

import Foundation

//MARK:- Web Service Protocol

protocol PostWebServiceProtocol : class {
    
    var interactor : PostInteractorOutputProtocol? {get set}
    
    var completion : ((CustomError?, Data?)->())? {get set}
    
    func retrieve(api : Base, url : String?, data : Data?, imageData: [String : Data]?, type : HttpType, completion : ((CustomError?, Data?)->())?)
    
}


//MARK:- Interator Input

protocol PostInteractorInputProtocol : class {
    
    var webService : PostWebServiceProtocol? {get set}
    
    func send(api : Base, data : Data?, type : HttpType)
    
    func send(api : Base, imageData : [String : Data]?, data : Data?)
    
    func send(api : Base, url : String, data : Data?, type : HttpType)
    
}


//MARK:- Interator Output

protocol PostInteractorOutputProtocol : class {
    
    var presenter : PostPresenterOutputProtocol? {get set}
    
    func on(api : Base, response : Data)
    
    func on(api : Base, error : CustomError)
    
}


//MARK:- Presenter Input

protocol PostPresenterInputProtocol : class {
    
    var interactor : PostInteractorInputProtocol? {get set}
    
    var controller : PostViewProtocol? {get set}
    /**
     Send POST Request
     @param api Api type to be called
     @param data HTTP Body
     */
    func post(api : Base, data : Data?)
    /**
     Send GET Request
     @param api Api type to be called
     @param parameters paramters to be send in request
     */
    
    func get(api : Base, data : Data?)
    
    /**
     Send GET Request
     @param api Api type to be called
     @param url : Custom url without base Url Eg : </api/user/{id}>
     */
    
    func get(api : Base, url : String)
    
    /**
     Send POST Request
     @param api Api type to be called
     @param imageData : Image to be sent in multipart
     @param parameters : params to be sent in multipart
     */
    func post(api : Base, imageData : [String : Data]?, data : Data?)
    
    /**
     Send put Request
     @param api Api type to be called
     @param url : Custom url without base Url Eg : </api/user/{id}>
     @param data HTTP Body
     */
    func put(api : Base, url : String, data : Data?)
    
    /**
     Send delete Request
     @param api Api type to be called
     @param url : Custom url without base Url Eg : </api/user/{id}>
     @param data HTTP Body
     */
    func delete(api : Base, url : String, data : Data?)
    
    /**
     Send patch Request
     @param api Api type to be called
     @param url : Custom url without base Url Eg : </api/user/{id}>
     @param data HTTP Body
     */
    func patch(api : Base, url : String, data : Data?)
    
    /**
     Send Post Request
     @param api Api type to be called
     @param url : Custom url without base Url Eg : </api/user/{id}>
     @param data HTTP Body
     */
    func post(api : Base, url : String, data : Data?)
    
    
}


//MARK:- Presenter Output

protocol PostPresenterOutputProtocol : class {
    
    func onError(api : Base, error : CustomError)
    func sendLoginEntity(api : Base, data : Data)
    func sendProfile(api : Base, data : Data)
    func sendShiftStatus(api : Base, data : Data)
    func sendVehicleEntityList(api : Base, data : Data)
    func sendNoticeEntityList(api : Base, data : Data)
    func sendLiveOrdersRequestEntity(api : Base, data : Data)
    func sendOrderHistoryList(api : Base, data :Data)
    func sendAcceptReject(api : Base, data :Data)
    func sendTransporterRating(api: Base, data: Data)
    func sendLiveOrderParam(api: Base, data: Data)
    func sendLogoutEntity(api : Base, data : Data)
    func sendSettingsData(api: Base, data: Data)


}


//MARK: - View

protocol PostViewProtocol : class {
    
    var presenter : PostPresenterInputProtocol? {get set}
    
    func onError(api : Base, message : String, statusCode code : Int)
    func getLoginEntity(api : Base, entity : LoginEntity?)
    func getProfile(api : Base, entity : Profile?)
    func getShiftStatusArray(api : Base, entity : [ShiftDetail])
    func getVehicleEntityList(api : Base, entity : [VehicleEntity])
    func getNoticeEntityList(api : Base, entity : [NoticeBoardEntity])
    func getLiveOrderRequest(api :Base, entity : [OrdersEntity])
    func getOrderHistory(api : Base, entity:[OrdersEntity])
    func getAcceptReject(api : Base, entity: AcceptRejectModel?)
    func getTransporterRating(api : Base, entity: TransporterRatingEntity?)
    func getLiveOrderParam(api: Base, entity: OrderModelEntity)
    func getLogoutEntity(api : Base, entity : LogoutEntity?)
    func getSettingsData(api: Base, data: SettingsEntity?)


}

//MARK: - View

extension PostViewProtocol {
    
    var presenter: PostPresenterInputProtocol? {
        
        get {
            presenterObject?.controller = self
            self.presenter = presenterObject
            return presenterObject
        }
        set(newValue){
            presenterObject = newValue
        }
        
    }
    
    func getLoginEntity(api : Base, entity : LoginEntity?) { return }
    func getProfile(api : Base, entity : Profile?) { return }
    func getShiftStatusArray(api : Base, entity : [ShiftDetail]) { return }
    func getVehicleEntityList(api : Base, entity : [VehicleEntity]) { return }
    func getNoticeEntityList(api : Base, entity : [NoticeBoardEntity]) { return }
    func getLiveOrderRequest(api : Base, entity: [OrdersEntity]) {return}
    func getOrderHistory(api : Base, entity:[OrdersEntity]) {return}
    func getAcceptReject(api : Base, entity: AcceptRejectModel?) {return}
    func getTransporterRating(api : Base, entity: TransporterRatingEntity?) {return}
    func getLiveOrderParam(api : Base, entity: OrderModelEntity) {return}
    func getLogoutEntity(api : Base, entity : LogoutEntity?) { return }
    func getSettingsData(api: Base, data: SettingsEntity?) {return}




}

// MARK:- View Structure
protocol UIViewStructure {
    //Responsible for initialization of all variables and data to be initiated only once
    func initalLoads()
    
    // All View Localization to be completely implemented here
    func localize()
    
    // Font Design Color and font handling to here implemented here
    func design()
    
    // All Constraint and size handling to be written here
    func layouts()
}



