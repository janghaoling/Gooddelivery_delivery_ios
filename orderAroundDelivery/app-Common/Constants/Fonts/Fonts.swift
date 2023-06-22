//
//  Fonts.swift
//  Project
//
//  Created by CSS on 25/01/19.
//  Copyright © 2019 css. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static func regular(size:CGFloat? = nil) -> UIFont {
        return UIFont(name: NunitoText.nunitoTextregular.rawValue, size: size ?? 14)!
    }
    static func bold(size:CGFloat? = nil) -> UIFont {
        return UIFont(name: NunitoText.nunitoTextbold.rawValue, size: size ?? 14)!
    }
    static func semibold(size:CGFloat? = nil) -> UIFont {
        return UIFont(name: NunitoText.nunitoTextsemibold.rawValue, size: size ?? 14)!
    }
    static func black(size:CGFloat? = nil) -> UIFont {
        return UIFont(name: NunitoText.nunitoTextBlack.rawValue, size: size ?? 14)!
    }
}
