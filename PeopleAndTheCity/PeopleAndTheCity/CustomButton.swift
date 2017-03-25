//
//  CustomButton.swift
//  PeopleAndTheCity
//
//  Created by Luna An on 3/25/17.
//  Copyright © 2017 Mimicatcodes. All rights reserved.
//

import Foundation

@IBDesignable class CustomButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
