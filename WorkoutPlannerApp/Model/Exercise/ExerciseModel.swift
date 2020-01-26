//
//  ExerciseModel.swift
//  WorkoutPlannerApp
//
//  Created by Kevin Vu on 12/18/19.
//  Copyright © 2019 Kevin Vu. All rights reserved.
//

import Foundation

// this is a class to hold individual exercises
// an exercise should have:
// 1) the exercise name
// 2) the number of sets
// 3) the weight being done in each set
// 4) the number of reps per set

class ExerciseModel: Codable {

    var title: String
    let id: String
    
    var setsInExercise = [ExerciseSetModel]()
    
    init(title: String) {
        self.title = title
        id = UUID().uuidString
        
    }
}
