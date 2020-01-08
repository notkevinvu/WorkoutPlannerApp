//
//  AddWorkoutViewController.swift
//  WorkoutPlannerApp
//
//  Created by Kevin Vu on 12/29/19.
//  Copyright © 2019 Kevin Vu. All rights reserved.
//

import UIKit

class AddWorkoutViewController: UIViewController {
    
    @IBOutlet weak var addWorkoutPopup: UIView!
    @IBOutlet weak var addWorkoutTitleLabel: UILabel!
    @IBOutlet weak var workoutTitleTextField: UITextField!
    @IBOutlet weak var cancelAddWorkoutButton: UIButton!
    @IBOutlet weak var saveAddWorkoutButton: UIButton!
    
    // this is a callback function, which is a property that contains a function
    // to give a variable a function type, we use () -> (), which are input and output parameters respectively (but we can leave them empty)
    // the actual code will be called in WorkoutViewController
    var doneSaving: (() -> ())?
    var workoutIndexToEdit: Int?
    var isFromEditButton: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addWorkoutPopup.addShadowAndRoundedCorners()
        addWorkoutPopup.layer.borderWidth = 2
        addWorkoutPopup.layer.borderColor = Theme.mainColor?.cgColor
        addWorkoutPopup.backgroundColor = Theme.background
        
        addWorkoutTitleLabel.textColor = Theme.accent
        addWorkoutTitleLabel.font = UIFont(name: Theme.mainFontName, size: 26)
        
        workoutTitleTextField.backgroundColor = Theme.accent
        workoutTitleTextField.placeholder = "Enter workout title..."
        
        // alternative to calling the next 13~ lines of code for the button configuration is to set up a custom UIButton class, where we utilize these options (similar to in our UIButtonExtension file) and have the buttons inherit the properties of that class (i.e. set the button as a subclass of the custom UIButton class)
        cancelAddWorkoutButton.setTitleColor(Theme.accent, for: .normal)
        saveAddWorkoutButton.setTitleColor(Theme.accent, for: .normal)
        
        cancelAddWorkoutButton.backgroundColor = Theme.tint
        saveAddWorkoutButton.backgroundColor = Theme.tint
        
        cancelAddWorkoutButton.layer.cornerRadius = cancelAddWorkoutButton.frame.height / 2
        cancelAddWorkoutButton.layer.shadowOpacity = 0.25
        cancelAddWorkoutButton.layer.shadowRadius = 4
        cancelAddWorkoutButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        saveAddWorkoutButton.layer.cornerRadius = saveAddWorkoutButton.frame.height / 2
        saveAddWorkoutButton.layer.shadowOpacity = 0.25
        saveAddWorkoutButton.layer.shadowRadius = 4
        saveAddWorkoutButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        cancelAddWorkoutButton.titleLabel?.font = UIFont(name: Theme.mainFontName, size: 20)
        saveAddWorkoutButton.titleLabel?.font = UIFont(name: Theme.mainFontName, size: 20)
        
        // if workoutIndexToEdit exists, we know we're in editing mode (i.e. this view controller was shown due to user pressing the edit button from the leading swipe action)
        if let index = workoutIndexToEdit {
            let workout = WorkoutData.workoutModels[index]
            workoutTitleTextField.text = workout.title
            isFromEditButton = true
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        // grab the text of the text field if it exists, sets it to workoutTitle,
        // dismisses and returns out of the function if nothing was entered,
        // otherwise, we create an instance of WorkoutModel using the workoutTitle as the title string
        // and then call createWorkout on that workout
        if let workoutTitle = workoutTitleTextField.text {
            workoutTitleTextField.rightViewMode = .never
            
            if workoutTitle.count == 0 {
                let titleWarningImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 34))
                titleWarningImageView.image = UIImage(systemName: "exclamationmark.triangle")
                titleWarningImageView.contentMode = .scaleAspectFit
                workoutTitleTextField.rightView = titleWarningImageView
                workoutTitleTextField.rightViewMode = .unlessEditing
                
                workoutTitleTextField.layer.borderColor = UIColor.red.cgColor
                workoutTitleTextField.layer.borderWidth = 2
                workoutTitleTextField.layer.cornerRadius = 5
                
                workoutTitleTextField.placeholder = "Workout title required"
                return
            }
            
            if isFromEditButton != nil {
                // isFromEditButton is true/exists, edit the existing workoutmodel rather than add
                let workoutToEdit = WorkoutData.workoutModels[workoutIndexToEdit!]
                WorkoutFunctions.updateWorkout(workoutModel: workoutToEdit, editedTitle: workoutTitle)
            } else {
                let workoutToSave = WorkoutModel(title: workoutTitle)
                WorkoutFunctions.createWorkout(workoutModel: workoutToSave)
            }
            
            
            // since the variable doneSaving can be nil (which would mean there is no code/function associated with it), we must check to see if there is a function/code set to it; if there is a function associated, we run that code
            if let doneSaving = doneSaving {
                doneSaving()
            }
            
            dismiss(animated: true, completion: nil)
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
