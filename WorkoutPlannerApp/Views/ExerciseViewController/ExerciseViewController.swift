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
    // currentWorkoutIndex is used to save data with a unique key (the index), show the exercises of the workout at the index, add exercises to the workout at index, and show the sets of the exercises of the workout
    var currentWorkoutIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegateAndDataSource()
         
        configureNavigationObjects()
        
        configureTableViewTheme()
        
        // parameter workoutIndex is used both as a unique key to save to user defaults and also to access the correct workoutModels object in array
        ExerciseFunctions.readExercise(workoutIndex: currentWorkoutIndex) { [weak self] in
            self?.exerciseTableView.reloadData()
        }
        
    } // end viewDidLoad()
    
    func setDelegateAndDataSource() {
        exerciseTableView.delegate = self
        exerciseTableView.dataSource = self
    }
    
    func configureNavigationObjects() {
        navigationController?.navigationBar.backgroundColor = Theme.background
        navigationItem.title = "\(WorkoutData.workoutModels[currentWorkoutIndex!].title)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.square.fill.on.square.fill"), style: .done, target: self, action: #selector(addExerciseToWorkout))
        navigationItem.rightBarButtonItem?.tintColor = Theme.tint
    }
    
    func configureTableViewTheme() {
        exerciseTableView.backgroundColor = Theme.background
    }
    
    @objc func addExerciseToWorkout() {

        var exerciseToAdd: ExerciseModel?
        
        let ac = UIAlertController(title: "Add Exercise", message: "Choose a new name for your new exercise", preferredStyle: .alert)

        // configuring cancel button action
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // add the text field
        ac.addTextField { (textField: UITextField!) in
            textField.placeholder = "Enter exercise name..."
            textField.textAlignment = .center
        }
        
        // configuring confirm addition of entered text as exercise
        let confirmAddButton = UIAlertAction(title: "Confirm", style: .default, handler: { [weak self] (alertaction) in
            
            guard let self = self else { return }
            
            // only save if there is text in the text field
            if let exerciseNameToAdd = ac.textFields![0].text {
                if exerciseNameToAdd == "" {
                    return
                }
                
                // create exercise model with entered text as title
                exerciseToAdd = ExerciseModel(title: exerciseNameToAdd)
                WorkoutData.workoutModels[(self.currentWorkoutIndex)].exercisesInWorkout.append(exerciseToAdd!)
                ExerciseFunctions.saveExercises(workoutIndex: (self.currentWorkoutIndex))
                self.exerciseTableView.reloadData()
            }
        })
        
        // adding all buttons/actions
        ac.addAction(cancelButton)
        ac.addAction(confirmAddButton)
        
        present(ac, animated: true)
        
    }
    
    @objc func addSetToExercise(sender: UIButton) {
        // grab the indexPath's section from the UIButton's tag we set when adding the button in viewForHeaderInSection
        let section = sender.tag
        
        let setAC = UIAlertController(title: "Add set", message: "Please enter the weight and number of reps for the set.", preferredStyle: .alert)
        
        setAC.addTextField { (weightTextField) in
            weightTextField.placeholder = "Enter weight of set..."
            weightTextField.textAlignment = .center
        }
        
        setAC.addTextField { (repsTextField) in
            repsTextField.placeholder = "Enter number of reps"
            repsTextField.textAlignment = .center
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let saveButton = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            
            guard let self = self else { return }
            
            // remove leading/trailing spaces
            let weightString = setAC.textFields?[0].text?.trimmingCharacters(in: .whitespaces)
            let repsString = setAC.textFields?[1].text?.trimmingCharacters(in: .whitespaces)
            
            if let weight = Double(weightString!) {
                if let reps = Int(repsString!) {
                    let exerciseSet = ExerciseSetModel(weightOfSet: weight, numberOfReps: reps)
                    
                    ExerciseFunctions.createExerciseSet(exerciseSetModel: exerciseSet, workoutIndex: self.currentWorkoutIndex, exerciseIndex: section)
                    
                    ExerciseFunctions.saveExercises(workoutIndex: self.currentWorkoutIndex)
                    self.exerciseTableView.reloadData()
                }
            }
        }
        
        setAC.addAction(cancelButton)
        setAC.addAction(saveButton)
        
        present(setAC, animated: true)
    } // end addSetToExercise
    
    @objc func longPressToDeleteExercise(sender: UILongPressGestureRecognizer) {
        let section = (sender.view?.tag)!
        
        let deleteAC = UIAlertController(title: "Delete exercise?", message: "Do you wish to delete exercise \"\(WorkoutData.workoutModels[currentWorkoutIndex!].exercisesInWorkout[section])?\"", preferredStyle: .alert)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let confirmButton = UIAlertAction(title: "Confirm", style: .destructive) { [weak self] (confirmAC) in
            
            guard let self = self else { return }
            
            ExerciseFunctions.deleteExercise(workoutIndex: (self.currentWorkoutIndex), exerciseIndex: section)
            
            var indexSet = IndexSet()
            indexSet.insert(section)
            
            self.exerciseTableView.deleteSections(indexSet, with: .automatic)
            self.exerciseTableView.reloadData()
        }
        
        deleteAC.addAction(cancelButton)
        deleteAC.addAction(confirmButton)
        
        present(deleteAC, animated: true)
        
    }
}

extension ExerciseViewController: UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    // MARK: Table view Sections (exercises)
    
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
        header.tag = section
        
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
        
        // long press gesture to delete exercise/section
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressToDeleteExercise(sender:)))
        header.addGestureRecognizer(longPressGesture)
        
        return header
    }
    
    // MARK: Table view rows (sets)
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WorkoutData.workoutModels[self.currentWorkoutIndex!].exercisesInWorkout[section].setsInExercise.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell") as! ExerciseTableViewCell
        
        // needs to correspond to the indexPath section, rather than the row
        cell.setup(exerciseModel: WorkoutData.workoutModels[currentWorkoutIndex!].exercisesInWorkout[indexPath.section], indexPath: indexPath)
        
        return cell
    }
    
    // delete exercise set
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let confirmDeleteAC = UIAlertController(title: "Confirm delete", message: "Are you sure you want to delete set #\(indexPath.row + 1)?", preferredStyle: .alert)
            
            confirmDeleteAC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            confirmDeleteAC.addAction((UIAlertAction(title: "Confirm", style: .destructive, handler: { [weak self] (alert) in
                
                guard let self = self else { return }
                
                ExerciseFunctions.deleteExerciseSet(workoutIndex: self.currentWorkoutIndex, exerciseIndex: indexPath.section, setIndex: indexPath.row)
                
                ExerciseFunctions.saveExercises(workoutIndex: self.currentWorkoutIndex)
                
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            })))
            
            present(confirmDeleteAC, animated: true)
                
        }
    }
    
    // edit exercise sets
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, actionPerformed: (Bool) -> ()) in
            
            let editSetAC = UIAlertController(title: "Edit Set", message: nil, preferredStyle: .alert)
            
            editSetAC.addTextField { [weak self] (weightTextField) in
                if let self = self {
                    weightTextField.textAlignment = .center
                    weightTextField.placeholder = "Edit weight of set..."
                    weightTextField.text = "\(WorkoutData.workoutModels[self.currentWorkoutIndex].exercisesInWorkout[indexPath.section].setsInExercise[indexPath.row].weightOfSet)"
                }
            }
            
            editSetAC.addTextField { [weak self] (repsTextField) in
                if let self = self {
                    repsTextField.textAlignment = .center
                    repsTextField.placeholder = "Edit number of reps..."
                    repsTextField.text = "\(WorkoutData.workoutModels[self.currentWorkoutIndex].exercisesInWorkout[indexPath.section].setsInExercise[indexPath.row].numberOfReps)"
                }
            }
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let saveButton = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
                
                guard let self = self else { return }
                
                if let weightString = editSetAC.textFields?[0].text?.trimmingCharacters(in: .whitespaces) {
                    if let repsString = editSetAC.textFields?[1].text?.trimmingCharacters(in: .whitespaces) {
                        
                        guard let weight = Double(weightString) else { return }
                        guard let reps = Int(repsString) else { return }
                        
                        WorkoutData.workoutModels[self.currentWorkoutIndex].exercisesInWorkout[indexPath.section].setsInExercise[indexPath.row].weightOfSet = weight
                        
                        WorkoutData.workoutModels[self.currentWorkoutIndex].exercisesInWorkout[indexPath.section].setsInExercise[indexPath.row].numberOfReps = reps
                        
                        ExerciseFunctions.saveExercises(workoutIndex: self.currentWorkoutIndex)
                        self.exerciseTableView.reloadData()
                    }
                }
            }
            
            editSetAC.addAction(cancelButton)
            editSetAC.addAction(saveButton)
            self.present(editSetAC, animated: true)
            
            actionPerformed(true)
        }
        
        return UISwipeActionsConfiguration(actions: [swipeAction])
    } // end leadingSwipeActionConfiguration
    
    
    
}

