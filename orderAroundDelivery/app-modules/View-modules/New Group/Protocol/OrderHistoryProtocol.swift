//
//  OrderHistoryProtocol.swift
//  Project
//
//  Created by CSS on 25/01/19.
//  Copyright © 2019 css. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: class{
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterOrderHistoryProtocol? {get set}
    func showMovieController(navigationController:UINavigationController)
    func startFetchingOrderHistory(type: String)

}

protocol PresenterToViewProtocol: class{
    func showOrderHistory(orderHistoryArray:Array<OrdersEntity>)
    func showError()
}

protocol PresenterToRouterOrderHistoryProtocol: class {
    static func createModule()-> OrderHistoryViewController
    func pushToMovieScreen(navigationConroller:UINavigationController)
}

protocol PresenterToInteractorProtocol: class {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchOrderHistory(type: String)
}

protocol InteractorToPresenterProtocol: class {
    func orderHistoryFetchedSuccess(orderHistoryModelArray:Array<OrdersEntity>)
    func OrderHistoryFetchFailed()
}
