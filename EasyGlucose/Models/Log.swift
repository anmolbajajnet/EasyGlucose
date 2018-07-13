//
//  Log.swift
//  EasyGlucose
//
//  Created by Anmol Bajaj on 2018-07-11.
//  Copyright © 2018 Glucinators. All rights reserved.
//


import Foundation
import RealmSwift

class Log: Object {
    
    
    // MARK: - Init
    convenience init(note: String) {
        self.init()
        self.note = note
    }
    
    // MARK: - Persisted Properties
    @objc dynamic var logID = UUID().uuidString //id that uniquely identifies the object
    @objc dynamic var note = ""
    @objc dynamic var timestamp = Date()
    
    // setting up the primary key
    override static func primaryKey() -> String? {
        return "logID"
    }

    
    
    
}
