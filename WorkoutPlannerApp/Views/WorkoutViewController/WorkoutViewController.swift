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
    
    // this index is only initialized when the user accesses the edit button through the leading swipe action (which takes in an indexPath, which we can grab the indexPath.row from and serves as our index)
    // this index will then be assigned to the destination view controller (addworkoutVC)'s workoutIndexToEdit property before the segue moves to that VC
    // in the addworkoutVC, if this value exists, it autopopulates the text field and sets the isFromEditButton property to true (which is then later checked in the save button function
    var workoutIndexToEdit: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: SETTING UP VIEW
        
        // configuring navigation title's text color and text
        let navBarTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.accent]
        navigationController?.navigationBar.titleTextAttributes = navBarTextAttributes as [NSAttributedString.Key : Any]
        navigationItem.title = "Workouts"
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.isTranslucent = true
//        let largeTitleAppearance = UINavigationBarAppearance()
//        largeTitleAppearance.backgroundColor = Theme.background
//        largeTitleAppearance.largeTitleTextAttributes = navBarTextAttributes as [NSAttributedString.Key : Any]
//        navigationController?.navigationBar.scrollEdgeAppearance = largeTitleAppearance
        
        
        
        // backBarButtonItem needs to be configured for the source view controller, not on the view controller it appears on
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Workouts", style: .done, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = Theme.accent
        
        // configuring color for navigation bar and the table view background
        navigationController?.navigationBar.barTintColor = Theme.background
        workoutTableView.backgroundColor = Theme.background
        
        tabBarController?.tabBar.barTintColor = Theme.backgroundContrast
        tabBarController?.tabBar.tintColor = Theme.accent
        tabBarController?.tabBar.items?[0].image = UIImage(systemName: "house.fill")
        tabBarController?.tabBar.items?[0].title = "Workouts"
        
        addWorkoutButton.createWorkoutButton()
        
        // MARK: Fetching and presenting data
        // these statements tell the table view that we want to use our class as the data source and the delegate
        // need to add the protocols to class definition (since we configure table view data in the extension, we can add protocols there)
        workoutTableView.dataSource = self
        // the delegate is telling the table view to use our code instead of the default code (e.g. heightForRowAt, etc)
        workoutTableView.delegate = self
        
        let defaults = UserDefaults.standard
        if let savedWorkouts = defaults.object(forKey: "workouts") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                WorkoutData.workoutModels = try jsonDecoder.decode([WorkoutModel].self, from: savedWorkouts)
            } catch {
                // present action controller/view for error loading workouts
            }
        }
        
        WorkoutFunctions.readWorkout { [weak self] in
            // the following code is called when the completion function gets called (i.e. after it retrieves data on the background thread
            self?.workoutTableView.reloadData()
        }
        
    } // end viewDidLoad
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "workoutToAddWorkoutSegue" {
            let popup = segue.destination as! AddWorkoutViewController
            // setting the workoutIndexToEdit in the AddWorkoutViewController to the workoutIndexToEdit here (which should get passed the indexPath.row before performing the segue to addworkoutVC)
            popup.workoutIndexToEdit = self.workoutIndexToEdit
            // use weak self in to prevent memory leak/strong reference cycles
            // alternatively, we can specify a function elsewhere and set popup.doneSaving to that function, but this is a shorthand method
            // this will only be called when we press the save button, since we only call doneSaving in the save function in AddWorkoutViewController
            popup.doneSaving = { [weak self] in
                self?.workoutTableView.reloadData()
            }
            self.workoutIndexToEdit = nil
        }
    }
    
} // end class

// MARK: Table View configuration

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // when we select a row in the table view, push the new view controller like so: (don't need to use a segue)
        if let newExerciseVC = storyboard?.instantiateViewController(withIdentifier: "exerciseViewController") as? ExerciseViewController {
            hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(newExerciseVC, animated: true)
            // to show bottom tabbar again, we set this property back to false after pushing the viewcontroller
            hidesBottomBarWhenPushed = false
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // alternative method to enable swipe to delete (but this utilizes a generic swipe, there is an inbuilt function called tableView(_:commit:forRowAt:)
    
    // in this scenario, trailing is at the right side
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteWorkout = UIContextualAction(style: .destructive, title: "Delete", handler: )
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let confirmDeleteAlert = UIAlertController(title: "Confirm delete", message: "Are you sure you want to delete the workout  \"\(WorkoutData.workoutModels[indexPath.row].title)\"?", preferredStyle: .alert)
            confirmDeleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            confirmDeleteAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (alert: UIAlertAction!) in
                // this error:
                // Cannot convert value of type '() -> ()' to expected argument type '((UIAlertAction) -> Void)?'
                // means that without the (alert: UIAlertAction!) in
                // part, this handler needs an input parameter
                // more specifically, ((UIAlertAction) -> Void)? is saying we need a UIAlertAction as the input parameter (so we specify this by putting (alert: UIAlertAction!) in)
                WorkoutFunctions.deleteWorkout(index: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }))
            present(confirmDeleteAlert, animated: true)
        }
    } // end commit editingStyle:

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editWorkout = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed: (Bool) -> ()) in
            self.workoutIndexToEdit = indexPath.row
            self.performSegue(withIdentifier: "workoutToAddWorkoutSegue", sender: nil)
            // actionPerformed is a bool that we can return true or false based on if we were able to finish the action; if we return true, it hides the swipeaction
            actionPerformed(true)
//            self.workoutIndexToEdit = nil
        }
        editWorkout.backgroundColor = Theme.mainColor
        editWorkout.image = UIImage(systemName: "pencil.circle.fill")

        return UISwipeActionsConfiguration(actions: [editWorkout])
    }

}
