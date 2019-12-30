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
        cancelAddWorkoutButton.layer.shadowRadius = 5
        
        saveAddWorkoutButton.layer.cornerRadius = saveAddWorkoutButton.frame.height / 2
        saveAddWorkoutButton.layer.shadowOpacity = 0.25
        saveAddWorkoutButton.layer.shadowRadius = 5
        
        cancelAddWorkoutButton.titleLabel?.font = UIFont(name: Theme.mainFontName, size: 20)
        saveAddWorkoutButton.titleLabel?.font = UIFont(name: Theme.mainFontName, size: 20)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
