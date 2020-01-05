//
//  ExerciseTableViewCell.swift
//  WorkoutPlannerApp
//
//  Created by Kevin Vu on 1/5/20.
//  Copyright © 2020 Kevin Vu. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    
    @IBOutlet weak var exerciseTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        exerciseTitleLabel.textColor = Theme.accent
        backgroundColor = Theme.background
        
    }

    func setup(exerciseModel: ExerciseModel) {
        exerciseTitleLabel.text = exerciseModel.title
    }

}

