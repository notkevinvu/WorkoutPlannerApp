//
//  UIButtonExtension.swift
//  WorkoutPlannerApp
//
//  Created by Kevin Vu on 12/29/19.
//  Copyright © 2019 Kevin Vu. All rights reserved.
//

import UIKit

extension UIButton {
    
    func createWorkoutButton() {
        // configuring the add workouts floating action button
        // point size can be used to change the scale of the image we are adding to the button
        let addWorkoutButtonConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .semibold)
        let addWorkoutButtonImage = UIImage(systemName: "plus", withConfiguration: addWorkoutButtonConfig)!
        setImage(addWorkoutButtonImage, for: .normal)
        
        tintColor = Theme.accent
        backgroundColor = Theme.tint
        // by setting the corner radius to half the frame's height/width (the same since we set the button to be 56x56), it will make the button a perfect circle
        layer.cornerRadius = frame.height / 2
        // making shadow of the button be seen
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        // positive height moves shadow downwards
        layer.shadowOffset = CGSize(width: 0, height: 8)
    }
    
    func configureAddWorkoutButtons() {
        setTitleColor(Theme.accent, for: .normal)
        backgroundColor = Theme.tint
        
        layer.cornerRadius = frame.height / 2
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 2)
        
        titleLabel?.font = UIFont(name: Theme.mainFontName, size: 20)
        
    }

}
