//
//  User.swift
//  User
//
//  Created by CSS on 17/01/18.
//  Copyright © 2018 Appoets. All rights reserved.
//


import Foundation

class User : NSObject, NSCoding, JSONSerializable {
    
    static var main = User()
    
    //@objc dynamic var id = 0
    
    var id : Int?
    var name : String?
    var accessToken : String?
    var latitude : Double?
    var lontitude : Double?
    var avatar : String?
    var email : String?
    var phone : String?
    var currency : String?
    var settlementStatus : String?
    
    init(id : Int?, name : String?, accessToken: String?, latitude: Double?, lontitude: Double?, email : String?, phoneNumber: String?,avatar: String?, currency: String?, settlementStatus : String?){
        
        self.id = id
        self.name = name
        self.accessToken = accessToken
        self.latitude = latitude
        self.lontitude = lontitude
        self.phone = phoneNumber
        self.email = email
        self.avatar = avatar
        self.currency = currency
        self.settlementStatus = settlementStatus
        
    }
    
    convenience
    override init(){
        
        self.init(id: nil, name: nil, accessToken: nil, latitude: nil, lontitude: nil, email: nil, phoneNumber:  nil, avatar: nil, currency: nil, settlementStatus: nil)
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let id = aDecoder.decodeObject(forKey: Keys.list.id) as? Int
        let name = aDecoder.decodeObject(forKey: Keys.list.name) as? String
        let accessToken = aDecoder.decodeObject(forKey: Keys.list.accessToken) as? String
        let latitude = aDecoder.decodeObject(forKey: Keys.list.latitude) as? Double
        let lontitude = aDecoder.decodeObject(forKey: Keys.list.lontitude) as? Double
        let email = aDecoder.decodeObject(forKey: Keys.list.email) as? String
        let phoneNumber = aDecoder.decodeObject(forKey: Keys.list.phone) as? String
        let avatar = aDecoder.decodeObject(forKey: Keys.list.avatar) as? String
        let currency = aDecoder.decodeObject(forKey: Keys.list.currency) as? String
        let settlementStatus = aDecoder.decodeObject(forKey: Keys.list.settlementStatus) as? String
        
        self.init(id: id, name: name, accessToken: accessToken, latitude: latitude, lontitude: lontitude, email: email, phoneNumber: phoneNumber, avatar: avatar, currency: currency, settlementStatus: settlementStatus)
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: Keys.list.id)
        aCoder.encode(self.name, forKey: Keys.list.name)
        aCoder.encode(self.accessToken, forKey: Keys.list.accessToken)
        aCoder.encode(self.lontitude, forKey: Keys.list.lontitude)
        aCoder.encode(self.latitude, forKey: Keys.list.latitude)
        aCoder.encode(self.email, forKey: Keys.list.email)
        aCoder.encodeConditionalObject(self.phone, forKey: Keys.list.phone)
        aCoder.encode(self.avatar, forKey: Keys.list.avatar)
        aCoder.encode(self.currency, forKey: Keys.list.currency)
        aCoder.encode(self.settlementStatus, forKey: Keys.list.settlementStatus)
    }
    
    
    
    
}









