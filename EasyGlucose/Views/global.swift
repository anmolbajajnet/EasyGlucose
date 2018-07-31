//
//  global.swift
//  EasyGlucose
//
//  Created by Anmol Bajaj on 2018-07-16.
//  Copyright © 2018 Glucinators. All rights reserved.
//

import Foundation
//This is a global class where global variables are stored the class gets called using mainInstance
class Main {
    var glucose:Int
    var imageURL:String
    var hasPicture:Bool
    var logArrayCount:Int
    var logDate:Date
    var carbMeasure:String
    var bloodPressureMeasure:String
    var engLang:Bool
    init(glucose:Int) {
        self.glucose = glucose
        self.imageURL = ""
        self.hasPicture = false
        self.logArrayCount = 0
        self.logDate = Date()
        self.carbMeasure = ""
        self.bloodPressureMeasure = ""
        self.engLang = true
        
       
    }
}
var mainInstance = Main(glucose:0)
