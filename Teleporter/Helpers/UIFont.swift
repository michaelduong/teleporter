//
//  UIFont.swift
//  Teleporter
//
//  Created by Michael Duong on 4/12/2019.
//  Copyright © 2019 Michael Duong. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func defaultFont(size: CGFloat) -> UIFont {
        return UIFont(name: UIFont.defaultFontName(), size: size)!
    }
    
    static func defaultFontName() -> String {
        return "Raleway-Regular"
    }
    
}
