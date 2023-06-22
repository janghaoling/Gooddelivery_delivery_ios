//
//  LiveTaskHelper.swift
//  Project
//
//  Created by CSS on 29/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import Foundation

class LiveTaskHelper {
    
    static var shared = LiveTaskHelper()
    private var timer : Timer?
    
    func startLisiteningLiveTask() {
        DispatchQueue.main.async {
            self.stopListeningLiveTask()
            self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { [weak self] (_) in
                self?.getData(on: { (error, entity) in
                    
                })
            })
        }
    }
    
    func stopListeningLiveTask() {
            self.timer?.invalidate()
            self.timer = nil
    }
    
     private func getData(on completion :  @escaping ((CustomError?,LoginEntity?)->Void)) {
        
        Webservice().retrieve(api: .liveOrders, url: nil, data: nil, imageData: nil, type: .GET) { (error, data) in
            print(data!)
        }
        
    }
    
}
