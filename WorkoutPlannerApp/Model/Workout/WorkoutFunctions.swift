//
//  WorkoutFunctions.swift
//  WorkoutPlannerApp
//
//  Created by Kevin Vu on 12/16/19.
//  Copyright © 2019 Kevin Vu. All rights reserved.
//

import Foundation

class WorkoutFunctions: NSObject, Codable {
    // the static keyword allows you to call the function without instantiating the class
    static func createWorkout(workoutModel: WorkoutModel) {
        WorkoutData.workoutModels.append(workoutModel)
        saveWorkouts()
    }
    
    // the parameter "completion: () -> ()" means that the function gets called when we finish getting data on the background thread
    // we need to specify that completion is an escaping parameter/closure by adding @escaping to it
    static func readWorkout(completion: @escaping () -> ()) {
        // .userInteractive is the highest priority background thread
        DispatchQueue.global(qos: .userInteractive).async {
            // if there are no WorkoutModels that exist, create a "fake"/template WorkoutModel to populate the main screen
            if WorkoutData.workoutModels.count == 0 {
                WorkoutData.workoutModels.append(WorkoutModel(title: "Back and Biceps"))
                WorkoutData.workoutModels.append(WorkoutModel(title: "Legs"))
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
    } // end readWorkout()
    
    static func updateWorkout(workoutModel: WorkoutModel) {
        
    }
    
    // can either pass in the uuid of the model or the whole model itself
    static func deleteWorkout(index: Int) {
        WorkoutData.workoutModels.remove(at: index)
        saveWorkouts()
    }
    
    static func saveWorkouts() {
        let jsonEncoder = JSONEncoder()
        if let savedWorkoutData = try? jsonEncoder.encode(WorkoutData.workoutModels) {
            let workoutsUserDefaults = UserDefaults.standard
            workoutsUserDefaults.set(savedWorkoutData, forKey: "workouts")
        } else {
            // present action controller or page denoting an error in saving/creating a workout
        }
    }
}
