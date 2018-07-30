//
//  Profile.swift
//  EasyGlucose
//
//  Created by Anmol Bajaj on 2018-07-30.
//  Copyright © 2018 Glucinators. All rights reserved.
//

import Foundation
import RealmSwift


class Profile:Object {
    convenience init(diabetesType:String, practionerEmail:String, userEmail:String, userName:String){
        self.init()
        self.diabetesType = diabetesType
        self.practitionerEmail = practionerEmail
        self.userEmail = userEmail
        self.userName = userName
    }
    @objc dynamic var profileID = UUID().uuidString //id that uniquely identifies the object
    @objc dynamic var diabetesType = ""
    @objc dynamic var practitionerEmail = ""
    @objc dynamic var userEmail = ""
    @objc dynamic var userName = ""

    override static func primaryKey() -> String? {
        return "profileID"
    }
    
    override class func indexedProperties()->[String]{
        return ["diabetesType","practitionerEmail", "userEmail", "username"]
    }
    
    
}
