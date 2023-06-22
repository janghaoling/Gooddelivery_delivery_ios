//
//  LogoutEntity.swift
//  Project
//
//  Created by CSS on 08/02/19.
//  Copyright © 2019 css. All rights reserved.
//

import Foundation
struct LogoutEntity : Codable {
    
    var message : String?
    
    
    enum CodingKeys: String, CodingKey {
        
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
    }
    
}
