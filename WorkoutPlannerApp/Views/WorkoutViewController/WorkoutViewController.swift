//
//  WorkoutViewController.swift
//  WorkoutPlannerApp
//
//  Created by Kevin Vu on 12/17/19.
//  Copyright © 2019 Kevin Vu. All rights reserved.
//

// Storyboard setup:
// Add view controller -> embed in navigation controller -> add table view and resize to fit entire screen -> go to identity inspector (4th icon top right) and choose class to be WorkoutViewController (i.e. this file) -> go to attributes inspector (5th icon top right) and check "Is initial view controller"
// Go to app properties (top level file on left side where you typically find device orientation and deployment info etc) and change the main interface from "main" to "WorkoutViewController" (i.e. this view controller)

import UIKit

class WorkoutViewController: UIViewController {

    @IBOutlet weak var workoutTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WorkoutFunctions.readWorkout { [weak self] in
            // the following code is called when the completion function gets called (i.e. after it retrieves data on the background thread
            self?.workoutTableView.reloadData()
        }
    }
    
    
    

}
