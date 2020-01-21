//
//  ExerciseViewController.swift
//  WorkoutPlannerApp
//
//  Created by Kevin Vu on 12/30/19.
//  Copyright © 2019 Kevin Vu. All rights reserved.
//

import UIKit

//protocol customHeaderDelegate {
//    func cell(cell: ExerciseTableViewCell, sender: UIGestureRecognizer)
//}

class ExerciseViewController: UIViewController {

    @IBOutlet weak var exerciseTableView: UITableView!
    
    @IBOutlet weak var addExerciseButton: UIButton!
    
    // when the ExerciseViewController is pushed to front, WorkoutViewController should set this property to the selected row's indexPath.row (thus it will correspond to the workout we selected)
    var currentWorkoutIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseTableView.delegate = self
        exerciseTableView.dataSource = self
        
        navigationController?.navigationBar.backgroundColor = Theme.background
        exerciseTableView.backgroundColor = Theme.background
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addExerciseToWorkout))
        
        // grab exercise data from userdefaults
        let defaults = UserDefaults.standard
        if let savedExercises = defaults.object(forKey: "exercises") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                WorkoutData.exerciseModels = try jsonDecoder.decode([ExerciseModel].self, from: savedExercises)
            } catch {
                // present action controller/view for error loading workouts
            }
        }
        
        ExerciseFunctions.readExercise { [weak self] in
            self?.exerciseTableView.reloadData()
        }
    }
    
    @objc func addExerciseToWorkout() {
        print("Yay")
        let exerciseTestAdd = ExerciseModel(title: "Test add exercise")
        WorkoutData.workoutModels[self.currentWorkoutIndex!].exercisesInWorkout.append(exerciseTestAdd)
        exerciseTableView.reloadData()
//        let ac = UIAlertController(title: "Add Exercise", message: "Choose a new name for your new exercise", preferredStyle: .alert)
//
//        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        ac.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (alertaction) in
//            if self.currentWorkoutIndex != nil {
//                print("Yay")
//
//                let exerciseToSave = ExerciseModel(title: "Test exercise add")
//                ExerciseFunctions.createExercise(exerciseModel: exerciseToSave, index: self.currentWorkoutIndex!)
//
//            }
//        }))
//        present(ac, animated: true)
        
    }
    
    @objc func addSetToExercise(sender: UIButton) {
        // grab the indexPath's section from the UIButton's tag we set when adding the button in viewForHeaderInSection
        let section = sender.tag
        WorkoutData.workoutModels[self.currentWorkoutIndex!].exercisesInWorkout[section].numOfSets += 1
        
        ExerciseFunctions.saveExercises()
        
        exerciseTableView.reloadData()
    }


}

// MARK: Table View

extension ExerciseViewController: UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    // MARK: Table view Sections
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return WorkoutData.workoutModels[self.currentWorkoutIndex!].exercisesInWorkout.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UITableViewHeaderFooterView()
        
        // setting header label
//        header.textLabel?.text = "\(WorkoutData.workoutModels[self.currentWorkoutIndex!].exercisesInWorkout[section].title)"
        header.textLabel?.text = "\(WorkoutData.workoutModels[self.currentWorkoutIndex!].exercisesInWorkout[section].title) - section: \(section + 1)"
        header.textLabel?.textColor = Theme.accent
        
        // setting up header view/background
        let headerBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: header.frame.width, height: header.frame.height))
        headerBackgroundView.backgroundColor = Theme.backgroundContrast
        header.backgroundView = headerBackgroundView
        
        // add top border
        let topHeaderBorderView = UIView(frame: CGRect(x: 0, y: 0.1, width: self.view.bounds.width, height: 1))
        topHeaderBorderView.backgroundColor = Theme.accent
        header.addSubview(topHeaderBorderView)
        
        // add bottom border
        let bottomHeaderBorderView = UIView(frame: CGRect(x: 0, y: 49.9, width: self.view.bounds.width, height: 1))
        bottomHeaderBorderView.backgroundColor = Theme.accent
        header.addSubview(bottomHeaderBorderView)
        
        // add button to add sets to the section
        let addSetButton = UIButton(frame: CGRect(x: 380, y: 10, width: 30, height: 30))
        addSetButton.backgroundColor = Theme.backgroundContrast
        addSetButton.tintColor = Theme.tint
        addSetButton.setImage(UIImage(systemName: "plus.app.fill"), for: .normal)
        addSetButton.tag = section
        addSetButton.addTarget(self, action: #selector(addSetToExercise(sender:)), for: .touchUpInside)
        header.addSubview(addSetButton)
        
        return header
    }
    
    // MARK: Table view rows
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WorkoutData.workoutModels[self.currentWorkoutIndex!].exercisesInWorkout[section].numOfSets
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell") as! ExerciseTableViewCell
        
        // needs to correspond to the indexPath section, rather than the row
        cell.setup(exerciseModel: WorkoutData.exerciseModels[indexPath.section], indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let confirmDeleteAC = UIAlertController(title: "Confirm delete", message: "Are you sure you want to delete set #\(WorkoutData.exerciseModels[indexPath.row])?", preferredStyle: .alert)
            
            confirmDeleteAC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            confirmDeleteAC.addAction((UIAlertAction(title: "Confirm", style: .destructive, handler: { (alert) in
                ExerciseFunctions.deleteExerciseSet(index: indexPath.section)
                tableView.deleteRows(at: [indexPath], with: .fade)
            })))
            
            present(confirmDeleteAC, animated: true)
                
        }
    }
    
    
}
