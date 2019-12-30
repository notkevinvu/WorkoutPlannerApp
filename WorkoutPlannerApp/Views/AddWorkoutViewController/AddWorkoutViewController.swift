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
        
        workoutTitleTextField.backgroundColor = Theme.accent
        // Do any additional setup after loading the view.
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
