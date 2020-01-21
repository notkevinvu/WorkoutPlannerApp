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
    
    // initialize as 0 for now, and create a function that will allow users to change the sets, weight, and reps
    // the function should be called after instantiating the class (i.e. when adding an exercise, ask for users to name the exercise first - this is the title - then, have a different popup/field that asks for the number of sets/reps and the weight)
    // may not need numOfSets later, just use setsInExercise.count
    var numOfSets: Int = 0
    var setsInExercise = [ExerciseSetModel]()
    
    init(title: String) {
        self.title = title
        id = UUID().uuidString
        
    }
}
