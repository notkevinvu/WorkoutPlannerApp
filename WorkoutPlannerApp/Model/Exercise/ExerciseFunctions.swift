//
//  ExerciseFunctions.swift
//  WorkoutPlannerApp
//
//  Created by Kevin Vu on 12/18/19.
//  Copyright © 2019 Kevin Vu. All rights reserved.
//

import Foundation

class ExerciseFunctions {
    static func createExercise(exerciseModel: ExerciseModel, index: Int) {
        WorkoutData.workoutModels[index].exercisesInWorkout.append(exerciseModel)
        saveExercises()
    }
    
    static func readExercise(completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            // if there are no exercises to display, populate with fake exercises
            if WorkoutData.exerciseModels.count == 0 {
                WorkoutData.exerciseModels.append(ExerciseModel(title: "Bench press"))
//                WorkoutData.exerciseModels.append(ExerciseModel(title: "Squat"))
//                WorkoutData.exerciseModels.append(ExerciseModel(title: "Deadlift"))
//                WorkoutData.exerciseModels.append(ExerciseModel(title: "Overhead Press"))
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    static func updateExercise(exerciseModel: ExerciseModel) {
        
    }
    
    static func deleteExercise(index: Int) {
        WorkoutData.exerciseModels.remove(at: index)
        saveExercises()
    }
    
    static func deleteExerciseSet(index: Int) {
        WorkoutData.exerciseModels[index].numOfSets -= 1
        saveExercises()
    }
    
    static func saveExercises() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(WorkoutData.exerciseModels) {
            let workoutsUserDefaults = UserDefaults.standard
            workoutsUserDefaults.set(savedData, forKey: "exercises")
        } else {
            // present action controller or page denoting an error in saving/creating a workout
        }
    }
}
