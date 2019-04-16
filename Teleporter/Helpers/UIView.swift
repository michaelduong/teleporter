//
//  UIView.swift
//  Teleporter
//
//  Created by Michael Duong on 4/12/2019.
//  Copyright © 2019 Michael Duong. All rights reserved.
//

import UIKit

extension UIView {
    
    var scale: CGFloat {
        set(value) {
            transform = CGAffineTransform(scaleX: value, y: value)
        }
        get {
            return 0
        }
    }
}
