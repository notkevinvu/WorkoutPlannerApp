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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        workoutCardView.layer.shadowOpacity = 1
        // by default, shadowOffset makes the shadow down and to the right (I think); setting it to 0 gives it zero offset
        workoutCardView.layer.shadowOffset = CGSize.zero
        workoutCardView.layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    
    func setup(workoutModel: WorkoutModel) {
        workoutTitleLabel.text = workoutModel.title
    }
}
