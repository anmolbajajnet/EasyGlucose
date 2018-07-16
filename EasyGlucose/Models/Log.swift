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
    convenience init(measurement: Int, tag:String, note: String, timeInRelationToMeal:String) {
        self.init()
        self.measurement = measurement
        self.tag = tag
        self.note = note
        self.timeInRelationToMeal = timeInRelationToMeal
        
    }
    
    // MARK: - Persisted Properties
    @objc dynamic var logID = UUID().uuidString //id that uniquely identifies the object
    @objc dynamic var measurement = 0
    @objc dynamic var timestamp = Date()
    @objc dynamic var tag = ""
    @objc dynamic var note = ""
    @objc dynamic var timeInRelationToMeal = "NULL"
    
    // setting up the primary key
    override static func primaryKey() -> String? {
        return "logID"
    }
    
    override class func indexedProperties()->[String]{
        return ["measurement","timestamp","tag", "Note", "timeInRelationToMeal"]
    }
}
class LogsManager: NSObject {
        
        static let shared = LogsManager()
        
        private override init() {
            super.init()
            
        }

    func addLog(_ note: String) {
        let realm = try! Realm()
        let log = Log()
        log.note = note
        log.timestamp = Date()
        
        do {
            try realm.write {
                realm.add(log)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getLogs() -> [Log]?{ //returns the log objects in an array
        let realm = try! Realm()
        let logs = realm.objects(Log.self)
        
        return logs.map({$0}) //get all the objects from the logs object and map will turn it into an array. std feature of swift
    }
    
}









