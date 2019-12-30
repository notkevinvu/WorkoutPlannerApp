//
//  UIViewExtensions.swift
//  WorkoutPlannerApp
//
//  Created by Kevin Vu on 12/26/19.
//  Copyright © 2019 Kevin Vu. All rights reserved.
//

import UIKit

extension UIView {
    func addShadowAndRoundedCorners() {
        layer.shadowOpacity = 1
        // by default, shadowOffset makes the shadow appear on the top side (i.e. a vertical y of -3.0
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 15
    }
    
}
