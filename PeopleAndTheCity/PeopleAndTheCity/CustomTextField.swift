//
//  CustomTextField.swift
//  PeopleAndTheCity
//
//  Created by Luna An on 3/25/17.
//  Copyright © 2017 Mimicatcodes. All rights reserved.
//

import Foundation

@IBDesignable class CustomTextField: UITextField {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            layer.borderColor = UIColor.black.cgColor
        }
    }
}
