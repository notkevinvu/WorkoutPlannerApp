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
        // by default, shadowOffset makes the shadow appear on the top side (i.e. a vertical y of -3.0
        workoutCardView.layer.shadowOffset = CGSize.zero
        workoutCardView.layer.shadowColor = UIColor.darkGray.cgColor
        workoutCardView.layer.cornerRadius = 15
        
    }
    
    func setup(workoutModel: WorkoutModel) {
        workoutTitleLabel.text = workoutModel.title
    }
}
