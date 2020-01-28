//
//  ExerciseFunctions.swift
//  WorkoutPlannerApp
//
//  Created by Kevin Vu on 12/18/19.
//  Copyright © 2019 Kevin Vu. All rights reserved.
//

import Foundation

class ExerciseFunctions {
    static func createExercise(exerciseModel: ExerciseModel, workoutIndex: Int) {
        WorkoutData.workoutModels[workoutIndex].exercisesInWorkout.append(exerciseModel)
        saveExercises(workoutIndex: workoutIndex)
    }
    
    static func createExerciseSet(exerciseSetModel: ExerciseSetModel, workoutIndex: Int, exerciseIndex: Int) {
        WorkoutData.workoutModels[workoutIndex].exercisesInWorkout[exerciseIndex].setsInExercise.append(exerciseSetModel)
    }
    
    static func readExercise(workoutIndex: Int, completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            // loading data from userdefaults with unique key workoutIndex
            let defaults = UserDefaults.standard
            if let savedExercises = defaults.object(forKey: "workout:\(workoutIndex)") as? Data {
                let jsonDecoder = JSONDecoder()
                
                do {
                    WorkoutData.workoutModels[workoutIndex].exercisesInWorkout = try jsonDecoder.decode([ExerciseModel].self, from: savedExercises)
                } catch {
                    // present action controller/view for error loading workouts
                }

            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    static func updateExercise(exerciseModel: ExerciseModel) {
        
    }
    
    static func deleteExercise(workoutIndex: Int, exerciseIndex: Int) {
        WorkoutData.workoutModels[workoutIndex].exercisesInWorkout.remove(at: exerciseIndex)
        saveExercises(workoutIndex: workoutIndex)
    }
    
    static func deleteExerciseSet(workoutIndex: Int, exerciseIndex: Int, setIndex: Int) {
        // workoutIndex is passed in when we go from workout screen to exercise screen
        // exerciseIndex should be the indexPath.section (since we use the section headers to hold our exercises)
        // setIndex should be the indexPath.row (since we use the table view cells/rows to hold the sets for each exercise)
        WorkoutData.workoutModels[workoutIndex].exercisesInWorkout[exerciseIndex].setsInExercise.remove(at: setIndex)
        saveExercises(workoutIndex: workoutIndex)
    }
    
    static func saveExercises(workoutIndex: Int) {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(WorkoutData.workoutModels[workoutIndex].exercisesInWorkout) {
            let workoutsUserDefaults = UserDefaults.standard
            // needs to save using a unique key, otherwise all workouts will be overwritten with one workout's exercises when loading data
            workoutsUserDefaults.set(savedData, forKey: "workout:\(workoutIndex)")
        } else {
            // present action controller or page denoting an error in saving/creating a workout
        }
    }
}
