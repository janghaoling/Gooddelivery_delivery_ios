//
//  File.swift
//  Project
//
//  Created by CSS on 24/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import Foundation

struct LoginEntity : JSONSerializable {
    var phone : String?
    var message : String?
    var otp : Int?
    var access_token : String?
   
}

