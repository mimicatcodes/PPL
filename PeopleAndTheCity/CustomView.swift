//
//  CustomView.swift
//  PeopleAndTheCity
//
//  Created by Luna An on 3/25/17.
//  Copyright © 2017 Mimicatcodes. All rights reserved.
//

import Foundation

@IBDesignable class CustomView: UIView {
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: CGColor = UIColor.black.cgColor {
        didSet {
            layer.borderColor = borderColor
        }
    }
}
