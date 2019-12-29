//
//  WorkoutTableViewCell.swift
//  WorkoutPlannerApp
//
//  Created by Kevin Vu on 12/18/19.
//  Copyright © 2019 Kevin Vu. All rights reserved.
//

// may want to revert to regular table view cells rather than spaced, separated cells

import UIKit

class WorkoutTableViewCell: UITableViewCell {
    
    @IBOutlet weak var workoutCardView: UIView!
    
    @IBOutlet weak var workoutTitleLabel: UILabel!

    // remember to put in outlets prior to awakeFromNib (ideally)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code (i.e. this is the code we want to execute first when the table view cell is created)
        
        workoutCardView.addShadowAndRoundedCorners()
        workoutTitleLabel.font = UIFont(name: Theme.mainFontName, size: 38)
        workoutCardView.backgroundColor = Theme.background
        
    }
    
    func setup(workoutModel: WorkoutModel) {
        workoutTitleLabel.text = workoutModel.title
    }
}
