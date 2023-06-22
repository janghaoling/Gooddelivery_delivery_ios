//
//  TransportRatingEntity.swift
//  Project
//
//  Created by CSS on 01/02/19.
//  Copyright © 2019 css. All rights reserved.
//

import Foundation
//{
//    "message": "Successfully Review Rating Done"
//}

struct TransporterRatingEntity : JSONSerializable {
    
    var message : String?
    var order_id : String?
    var rating : String?
    var comment : String?
    
    
}
