//
//  OrderHistoryInteractor.swift
//  Project
//
//  Created by CSS on 25/01/19.
//  Copyright © 2019 css. All rights reserved.
//

import Foundation
import Alamofire

class OrderHistoryInteractor: PresenterToInteractorProtocol {
    var presenter: InteractorToPresenterProtocol?
    
    init(presenter: InteractorToPresenterProtocol) {
        self.presenter = presenter
    }
    
    func fetchOrderHistory(type: String) {
        let orderHistoryurl = APIConstant.baseURL + EndPoints.orderHistory.rawValue
        
        let param = [ "type": type ]
        let headers: HTTPHeaders = [
            WebConstants.string.secretKey: EndPoints.orderHistory.rawValue,
            WebConstants.string.Content_Type: WebConstants.string.application_json,
            WebConstants.string.X_Requested_With: WebConstants.string.XMLHttpRequest ,
            WebConstants.string.Authorization: WebConstants.string.bearer+String.removeNil(User.main.accessToken)
        ]
        
        Alamofire.request(orderHistoryurl, method: .get, parameters: param, encoding: URLEncoding(destination: .queryString), headers: headers).responseString(queue: DispatchQueue.global(qos: .utility)) { response in
            if response.result.error == nil && response.result.isSuccess {
                do  {
                    let jsonDecoder = JSONDecoder()
                    let data = try jsonDecoder.decode([OrdersEntity].self, from: response.data!)
                    DispatchQueue.main.async {
                        self.presenter?.orderHistoryFetchedSuccess(orderHistoryModelArray: data)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.presenter?.OrderHistoryFetchFailed()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.presenter?.OrderHistoryFetchFailed()
                }
            }
        }
    }
}
