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
    // MARK: - Persisted Properties
   @objc dynamic var id = UUID().uuidString
   @objc dynamic var glucose = 0
   @objc dynamic var note = ""
   @objc dynamic var isFavorite = false
   @objc dynamic var timestamp = Date().timeIntervalSinceReferenceDate
    
    override static func primaryKey() -> String? {
        return "id"
    }
    

// MARK: - Dynamic properties
// MARK: - Meta
// MARK: - Etc

}


