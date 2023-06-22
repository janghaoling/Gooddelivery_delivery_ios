//
//  OrderHistoryPresenter.swift
//  Project
//
//  Created by CSS on 25/01/19.
//  Copyright © 2019 css. All rights reserved.
//

import Foundation
import UIKit

class OrderHistoryPresenter:ViewToPresenterProtocol {
   
    var view: PresenterToViewProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterOrderHistoryProtocol?
    
    init(view: PresenterToViewProtocol) {
        self.view = view
        interactor = OrderHistoryInteractor(presenter: self)
        router = OrderHistoryRouter()
    }
    
    func startFetchingOrderHistory(type: String) {
        interactor?.fetchOrderHistory(type: type)
    }
    
    func showMovieController(navigationController: UINavigationController) {
        router?.pushToMovieScreen(navigationConroller:navigationController)
    }
    
}

extension OrderHistoryPresenter: InteractorToPresenterProtocol{
    func orderHistoryFetchedSuccess(orderHistoryModelArray: Array<OrdersEntity>) {
        view?.showOrderHistory(orderHistoryArray:orderHistoryModelArray)
    }
    
    func OrderHistoryFetchFailed() {
        view?.showError()

    }
}
