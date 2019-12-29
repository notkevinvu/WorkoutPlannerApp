//
//  Theme.swift
//  WorkoutPlannerApp
//
//  Created by Kevin Vu on 12/26/19.
//  Copyright © 2019 Kevin Vu. All rights reserved.
//

// For fonts, must add the font to the app's assets/folder (can use the font book app to search and find the font files - can only use .ttf or .otf)
// After adding the app, must configure info.plist to show that we are using a specific font that we added (add a row, select "Fonts provided by application", add under the item's string)

import UIKit

class Theme {
    // for the string names, use font book and look at its info (click the info button top left after selecting it in font book) and use the postscript name
//    static let mainFontName = "Cochin"
    static let mainFontName = "SFProRounded-Medium"
    
    // constants for using colors in code for the table view cells and other views
    // use accent for text
    static let accent = UIColor(named: "Accent")
    // background is for the true background
    static let background = UIColor(named: "Background")
    // use contrast for card view, so that 
    static let backgroundContrast = UIColor(named: "BackgroundContrast")
    // use tint for interactive UI elements
    static let tint = UIColor(named: "Tint")
    // use main color for any design elements that don't use text/background
    static let mainColor = UIColor(named: "MainColor")
    static let lightAccent = UIColor(named: "LightAccent")
    
}
