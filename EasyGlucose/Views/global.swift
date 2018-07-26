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
    init(glucose:Int) {
        self.glucose = glucose
        self.imageURL = ""
        self.hasPicture = false
        
       
    }
}
var mainInstance = Main(glucose:0)
