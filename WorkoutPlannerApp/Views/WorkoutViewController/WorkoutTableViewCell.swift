//
//  WorkoutTableViewCell.swift
//  WorkoutPlannerApp
//
//  Created by Kevin Vu on 12/18/19.
//  Copyright © 2019 Kevin Vu. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {
    
    @IBOutlet weak var workoutCardView: UIView!
    
    @IBOutlet weak var workoutTitleLabel: UILabel!

    // remember to put in outlets prior to awakeFromNib (ideally)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code (i.e. this is the code we want to execute first when the table view cell is created)
        
        workoutCardView.addShadowAndRoundedCorners()
        
    }
    
    func setup(workoutModel: WorkoutModel) {
        workoutTitleLabel.text = workoutModel.title
    }
}
