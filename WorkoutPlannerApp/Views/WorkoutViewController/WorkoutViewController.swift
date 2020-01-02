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
        
        // configuring navigation title's text color and text
        let navBarTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.accent]
        navigationController?.navigationBar.titleTextAttributes = navBarTextAttributes as [NSAttributedString.Key : Any]
        navigationItem.title = "Workouts"
//        navigationController?.navigationBar.prefersLargeTitles = true
        
        // configuring color for navigation bar and the table view background
        navigationController?.navigationBar.barTintColor = Theme.background
        workoutTableView.backgroundColor = Theme.background
        
        // configuring the floating action button to add workouts
        // point size can be used to change the scale of the image we are adding to the button
        let addWorkoutButtonConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .semibold)
        let addWorkoutButtonImage = UIImage(systemName: "plus", withConfiguration: addWorkoutButtonConfig)!
        addWorkoutButton.createWorkoutButton(UIButton: addWorkoutButton, config: addWorkoutButtonConfig, image: addWorkoutButtonImage)
        
        
        // these statements tell the table view that we want to use our class as the data source and the delegate
        // need to add the protocols to class definition
        workoutTableView.dataSource = self
        // the delegate is telling the table view to use our code instead of the default code (e.g. heightForRowAt, etc)
        workoutTableView.delegate = self
        
        WorkoutFunctions.readWorkout { [weak self] in
            // the following code is called when the completion function gets called (i.e. after it retrieves data on the background thread
            self?.workoutTableView.reloadData()
        }
    } // end viewDidLoad
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "workoutToAddWorkoutSegue" {
            let popup = segue.destination as! AddWorkoutViewController
            // use weak self in to prevent memory leak/strong reference cycles
            // alternatively, we can specify a function elsewhere and set popup.doneSaving to that function, but this is a shorthand method
            // this will only be called when we press the save button, since we only call doneSaving in the save function in AddWorkoutViewController
            popup.doneSaving = { [weak self] in
                self?.workoutTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // when we select a row in the table view, push the new view controller like so: (don't need to use a segue)
        if let newExerciseVC = storyboard?.instantiateViewController(withIdentifier: "exerciseViewController") as? ExerciseViewController {
            navigationController?.pushViewController(newExerciseVC, animated: true)
        }
    }
} // end class

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
    
    
    // alternative method to enable swipe to delete (but this utilizes a generic swipe, there is an inbuilt function called tableView(_:commit:forRowAt:)
    
    // in this scenario, trailing is at the right side
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteWorkout = UIContextualAction(style: .destructive, title: "Delete", handler: )
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            WorkoutData.workoutModels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
