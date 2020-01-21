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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseTableView.delegate = self
        exerciseTableView.dataSource = self
        
        navigationController?.navigationBar.backgroundColor = Theme.background
        exerciseTableView.backgroundColor = Theme.background
        
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
    
    @objc func addSetToExercise(sender: UIButton) {
        // grab the indexPath's section from the UIButton's tag we set when adding the button in viewForHeaderInSection
        let section = sender.tag
        WorkoutData.exerciseModels[section].numOfSets += 1
        
        ExerciseFunctions.saveExercises()
        
        exerciseTableView.reloadData()
    }


}

// MARK: Table View

extension ExerciseViewController: UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return WorkoutData.exerciseModels[section].numOfSets
    }
       
       func numberOfSections(in tableView: UITableView) -> Int {
           return WorkoutData.exerciseModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UITableViewHeaderFooterView()
        
        header.textLabel?.text = "\(WorkoutData.exerciseModels[section].title) - section: \(section)"
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell") as! ExerciseTableViewCell
        
        // needs to correspond to the indexPath section, rather than the row
        cell.setup(exerciseModel: WorkoutData.exerciseModels[indexPath.section], indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
