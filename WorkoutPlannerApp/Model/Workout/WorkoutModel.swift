//
//  WorkoutModel.swift
//  WorkoutPlannerApp
//
//  Created by Kevin Vu on 12/16/19.
//  Copyright © 2019 Kevin Vu. All rights reserved.
//

// holds the blueprint for workout data, which should contain exercises, day of the week

import Foundation

class WorkoutModel {
    var title: String!
    var id: String!
    
    init(title: String) {
        id = UUID().uuidString
        self.title = title
    }
    
    
}
