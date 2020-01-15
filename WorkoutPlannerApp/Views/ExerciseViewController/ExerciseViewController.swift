//
//  ExerciseViewController.swift
//  WorkoutPlannerApp
//
//  Created by Kevin Vu on 12/30/19.
//  Copyright © 2019 Kevin Vu. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {

    @IBOutlet weak var exerciseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseTableView.delegate = self
        exerciseTableView.dataSource = self
        
        navigationController?.navigationBar.backgroundColor = Theme.background
        exerciseTableView.backgroundColor = Theme.background
        
        ExerciseFunctions.readExercise { [weak self] in
            self?.exerciseTableView.reloadData()
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

// MARK: Table View

extension ExerciseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WorkoutData.exerciseModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell") as! ExerciseTableViewCell
        
        // configuring accessory view with custom accessory color
        cell.tintColor = Theme.mainColor
        let customDisclosureImage = UIImage(systemName: "chevron.right.circle.fill")!
        let disclosureImageFrame = UIImageView(frame: CGRect(x: 0, y: 0, width: ((customDisclosureImage.size.width)), height: ((customDisclosureImage.size.height))))
        disclosureImageFrame.image = customDisclosureImage
        cell.accessoryView = disclosureImageFrame
        
        cell.setup(exerciseModel: WorkoutData.exerciseModels[indexPath.row])
        
//        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
