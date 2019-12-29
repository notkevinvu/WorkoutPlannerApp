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
    
    @IBOutlet weak var addWorkoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Workouts"
//        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.barTintColor = Theme.mainColor
        workoutTableView.backgroundColor = Theme.background
        
        // point size can be used to change the scale of the image we are adding to the button
        let addWorkoutButtonConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .semibold)
        let addWorkoutButtonImage = UIImage(systemName: "plus", withConfiguration: addWorkoutButtonConfig)
        addWorkoutButton.setImage(addWorkoutButtonImage, for: .normal)
        addWorkoutButton.tintColor = Theme.accent
        addWorkoutButton.backgroundColor = Theme.tint
        // by setting the corner radius to half the frame's height/width (the same since we set the button to be 56x56), it will make the button a perfect circle
        addWorkoutButton.layer.cornerRadius = addWorkoutButton.frame.height / 2
        // making shadow of the button be seen
        addWorkoutButton.layer.shadowOpacity = 0.25
        addWorkoutButton.layer.shadowRadius = 5
        // positive height moves shadow downwards
        addWorkoutButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        
        
        // these statements tell the table view that we want to use our class as the data source and the delegate
        // need to add the protocols to class definition
        workoutTableView.dataSource = self
        // the delegate is telling the table view to use our code instead of the default code (e.g. heightForRowAt, etc)
        workoutTableView.delegate = self
        
        WorkoutFunctions.readWorkout { [weak self] in
            // the following code is called when the completion function gets called (i.e. after it retrieves data on the background thread
            self?.workoutTableView.reloadData()
        }
    }
}

// moved tableView configuration code into its own extension of the WorkoutViewController class to partition more distinctly
// alternatively, we could potentially just put this extension in a different file, but it is unnecessary at the moment
extension WorkoutViewController: UITableViewDataSource, UITableViewDelegate {
    
    // configures the table view to show the count of workout models (REQUIRED for UITableViewDataSource)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WorkoutData.workoutModels.count
    }
    
    // tells the table view what kind of cells to show and configures any properties (REQUIRED for UITableViewDataSource)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell") as! WorkoutTableViewCell
        
        cell.setup(workoutModel: WorkoutData.workoutModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 140 is the height of the cell/its content view
        return 140
    }
    

}
