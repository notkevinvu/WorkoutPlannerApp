//
//  ExerciseSetModel.swift
//  WorkoutPlannerApp
//
//  Created by Kevin Vu on 1/21/20.
//  Copyright © 2020 Kevin Vu. All rights reserved.
//

import Foundation

struct ExerciseSetModel: Codable {
    
    var setNumber: Int
    var weightOfSet: Int = 0
    var numberOfReps: Int = 0
    
}
