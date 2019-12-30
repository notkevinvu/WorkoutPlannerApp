//
//  UIButtonExtension.swift
//  WorkoutPlannerApp
//
//  Created by Kevin Vu on 12/29/19.
//  Copyright © 2019 Kevin Vu. All rights reserved.
//

import UIKit

extension UIButton {

    func createWorkoutButton(UIButton: UIButton, config: UIImage.SymbolConfiguration, image: UIImage) {
        UIButton.setImage(image, for: .normal)
        UIButton.tintColor = Theme.accent
        UIButton.backgroundColor = Theme.tint
        // by setting the corner radius to half the frame's height/width (the same since we set the button to be 56x56), it will make the button a perfect circle
        UIButton.layer.cornerRadius = UIButton.frame.height / 2
        // making shadow of the button be seen
        UIButton.layer.shadowOpacity = 0.25
        UIButton.layer.shadowRadius = 5
        // positive height moves shadow downwards
        UIButton.layer.shadowOffset = CGSize(width: 0, height: 8)
    }

}
