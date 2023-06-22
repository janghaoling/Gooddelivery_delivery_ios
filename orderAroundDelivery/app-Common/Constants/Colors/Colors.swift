//
//  Colors.swift
//  User
//
//  Created by imac on 12/22/17.
//  Copyright © 2017 Appoets. All rights reserved.
//

import UIKit

enum Color : Int {
    
    case primary = 1
    case secondary = 2
    case bgWhite = 3
    case brightBlue = 4
    
    
    static func valueFor(id : Int)->UIColor?{
        
        switch id {
        case self.primary.rawValue:
            return .primary
        
        case self.secondary.rawValue:
            return .secondary
            
        case self.bgWhite.rawValue:
            return .bgWhite
        
        case self.brightBlue.rawValue:
            return .brightBlue
            
        default:
            return nil
        }
        
        
    }
    
    
}

extension UIColor {
    
    // Primary Color
    static var primary : UIColor {
        return #colorLiteral(red: 1, green: 0.4274509804, blue: 0, alpha: 1)//UIColor(red: 149/255, green: 116/255, blue: 205/255, alpha: 1)
    }
    
    // Secondary Color
    static var secondary : UIColor {
        return #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)//UIColor(red: 238/255, green: 98/255, blue: 145/255, alpha: 1) (64, 187, 55)
    }
    
    // Secondary Color
    static var bgWhite : UIColor {
        return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) //UIColor(red: 38/255, green: 118/255, blue: 188/255, alpha: 1)
    }
    static var liveTaskColor : UIColor {
        return UIColor(red: 255/255, green: 77/255, blue: 42/255, alpha: 1)

    }
    static var UpcomingColor : UIColor {
        return UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)

    }
    
    static var baseColor : UIColor {
        return UIColor(red: 237/255, green: 28/255, blue: 36/255, alpha: 1)
        
    }
    static var onGoingColor : UIColor {
        return UIColor(red: 70/255, green: 137/255, blue: 26/255, alpha: 1)
        
    }
    static var descDarkColor : UIColor {
        return UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
        
    }
    static var orderStatusSuccessColor : UIColor {
        return UIColor(red: 114/255, green: 141/255, blue: 80/255, alpha: 1)
        
    }

    static var acceptColor : UIColor {
        return UIColor(red: 84/255, green: 181/255, blue: 138/255, alpha: 1)
        
    }
    
    static var Color : UIColor {
        return UIColor(red: 237/255, green: 28/255, blue: 36/255, alpha: 1)
        
    }
    static var descColor : UIColor {
        return UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 1)
        
    }
    
    static var completedTask : UIColor {
        return UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        
    }

    static var completedTaskColor : UIColor {
        return UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        
    }
    
    //Gradient Start Color
    
    static var startGradient : UIColor {
        return UIColor(red: 83/255, green: 173/255, blue: 46/255, alpha: 1)
    }
    
    //Gradient End Color
    
    static var endGradient : UIColor {
        return UIColor(red: 158/255, green: 178/255, blue: 45/255, alpha: 1)
    }
    
    // Blue Color
    
    static var brightBlue : UIColor {
        return UIColor(red: 40/255, green: 25/255, blue: 255/255, alpha: 1)
    }
    
    
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static let backgroundColor = UIColor.rgb(r: 21, g: 22, b: 33)
    static let outlineStrokeColor = UIColor.rgb(r: 234, g: 46, b: 111)
    static let trackStrokeColor = UIColor.rgb(r: 56, g: 25, b: 49)
    static let pulsatingFillColor = UIColor.rgb(r: 86, g: 30, b: 63)
    
    
}




