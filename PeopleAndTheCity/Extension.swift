//
//  Extension.swift
//  PeopleAndTheCity
//
//  Created by Mirim An on 3/24/17.
//  Copyright © 2017 Mimicatcodes. All rights reserved.
//

import Foundation

extension UIColor {
    static func rgb(_ red: CGFloat,_ green: CGFloat,_ blue: CGFloat,_ alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
}
