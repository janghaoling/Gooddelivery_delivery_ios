//
//  OrderHistoryRouter.swift
//  Project
//
//  Created by CSS on 25/01/19.
//  Copyright © 2019 css. All rights reserved.
//

import Foundation
import UIKit

class OrderHistoryRouter:PresenterToRouterOrderHistoryProtocol{
    
    static func createModule() -> OrderHistoryViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "OrderHistoryViewController") as! OrderHistoryViewController
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func pushToMovieScreen(navigationConroller navigationController:UINavigationController) {
        
        // let movieModue = MovieRouter.createMovieModule()
        //   navigationController.pushViewController(movieModue,animated: true)
        
    }
    
}
