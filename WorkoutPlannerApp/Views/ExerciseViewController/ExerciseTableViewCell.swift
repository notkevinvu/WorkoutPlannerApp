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
        
        isUserInteractionEnabled = false
        
    }

    func setup(exerciseModel: ExerciseModel, indexPath: IndexPath) {
        
        let weight = exerciseModel.setsInExercise[indexPath.row].weightOfSet
        let reps = exerciseModel.setsInExercise[indexPath.row].numberOfReps
        
        exerciseTitleLabel.text = "Set #: \(indexPath.row + 1) -- weight: \(weight) --  reps: \(reps)"
    }

}

