//
//  EditWorkoutViewController.swift
//  WorkoutPlannerApp
//
//  Created by Kevin Vu on 1/6/20.
//  Copyright © 2020 Kevin Vu. All rights reserved.
//

import UIKit

class EditWorkoutViewController: UIViewController {

    @IBOutlet weak var editWorkoutView: UIView!
    @IBOutlet weak var editWorkoutTitleLabel: UILabel!
    @IBOutlet weak var editWorkoutTextField: UITextField!
    @IBOutlet weak var editWorkoutCancelButton: UIButton!
    @IBOutlet weak var editWorkoutSaveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelEdit(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveEdit(_ sender: UIButton) {
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
