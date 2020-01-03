//
//  WorkoutModel.swift
//  WorkoutPlannerApp
//
//  Created by Kevin Vu on 12/16/19.
//  Copyright © 2019 Kevin Vu. All rights reserved.
//

// holds the blueprint for workout data, which should contain exercises, day of the week

import Foundation

class WorkoutModel: Codable {
    // don't need to make title or id optional, will always have a value
    // ex:
    // var needsInitialValue: String // not optional
    // var noInitialValueButWillHaveOneLater: String! // optional
    // var initialValueIsNil: String? // optional
    var title: String
    // don't need to change id after setting it, changed var -> let
    let id: String
    
    init(title: String) {
        id = UUID().uuidString
        self.title = title
    }
    
    
}
