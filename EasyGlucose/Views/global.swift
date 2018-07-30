//
//  global.swift
//  EasyGlucose
//
//  Created by Anmol Bajaj on 2018-07-16.
//  Copyright © 2018 Glucinators. All rights reserved.
//

import Foundation

class Main {
    var glucose:Int
    var imageURL:String
    var hasPicture:Bool
    var logArrayCount:Int
    var logDate:Date
    var carbMeasure:String
    var bloodPressureMeasure:String
    init(glucose:Int) {
        self.glucose = glucose
        self.imageURL = ""
        self.hasPicture = false
        self.logArrayCount = 0
        self.logDate = Date()
        self.carbMeasure = ""
        self.bloodPressureMeasure = ""
        
       
    }
}
var mainInstance = Main(glucose:0)
