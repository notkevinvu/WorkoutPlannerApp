//
//  ExerciseFunctions.swift
//  WorkoutPlannerApp
//
//  Created by Kevin Vu on 12/18/19.
//  Copyright © 2019 Kevin Vu. All rights reserved.
//

import Foundation

class ExerciseFunctions {
    static func createExercise(exerciseModel: ExerciseModel) {
        
    }
    
    static func readExercise(completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            // if there are no exercises to display, populate with fake exercises
            if WorkoutData.exerciseModels.count == 0 {
                WorkoutData.exerciseModels.append(ExerciseModel(title: "Bench press"))
                WorkoutData.exerciseModels.append(ExerciseModel(title: "Squat"))
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    static func updateExercise(exerciseModel: ExerciseModel) {
        
    }
    
    static func deleteExercise(id: UUID) {
        
    }
}
