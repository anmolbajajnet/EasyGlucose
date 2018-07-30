//
//  ProfileViewController.swift
//  EasyGlucose
//
//  Created by Anmol Bajaj on 2018-07-11.
//  Copyright © 2018 Glucinators. All rights reserved.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController {


    @IBOutlet weak var avgLabel: UILabel!
    @IBOutlet weak var avgCarbs: UILabel!
    @IBOutlet weak var avgBP: UILabel!
    
    
    @IBOutlet weak var nameDisplay: UILabel!
    @IBOutlet weak var emailDisplay: UILabel!
    @IBOutlet weak var typeDisplay: UILabel!
    @IBOutlet weak var healthEmailDisplay: UILabel!
    @IBOutlet weak var nameTopDisplay: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillProfile()
        avgCalculation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        avgCalculation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    func fillProfile(){
        let realm = try! Realm()
        let profile = realm.objects(Profile.self)
        let profileArr = profile.map({$0})
        if(profileArr.count == 1){
            nameDisplay.text = profileArr[0].userName
            emailDisplay.text = profileArr[0].userEmail
            typeDisplay.text = profileArr[0].diabetesType
            healthEmailDisplay.text = profileArr[0].practitionerEmail
            nameTopDisplay.text = profileArr[0].userName
        }
    }
    
    func avgCalculation() {
        if mainInstance.logArrayCount == 0 {
            let zero = 0
            avgLabel.text = String(zero)
            avgCarbs.text = String(zero)
            avgBP.text = String(zero)
            
        }
        else {
            let realm = try! Realm()
            let data = realm.objects(Log.self)
            let dataArr = data.map({$0})
            var validCarbCount = 0
            var carbSum = 0
            var validBloodPressureCount = 0
            var bloodPressureSum = 0
            var glucoseSum = 0
            
            
            for logObj in dataArr {
                
                if Int(logObj.carbMeasurement) != nil{
                    if Int(logObj.carbMeasurement)! != 0 {
                        validCarbCount += 1
                        carbSum += Int(logObj.carbMeasurement)!
                    }
                }
                if Int (logObj.bloodPressureMeasurement) != nil{
                    if Int(logObj.bloodPressureMeasurement) != 0{
                        validBloodPressureCount += 1
                        bloodPressureSum += Int(logObj.bloodPressureMeasurement)!
                    }
                }
                glucoseSum += logObj.measurement
            }
            print(validCarbCount)
            print(validBloodPressureCount)
            
            avgLabel.text = String(glucoseSum / dataArr.count)
            if validCarbCount != 0 {
                avgCarbs.text = String(carbSum / validCarbCount)
            }else {
                avgCarbs.text = String(0)
            }
            if validBloodPressureCount != 0 {
                avgBP.text = String(bloodPressureSum/validBloodPressureCount)
            }else{
                avgBP.text = String(0)
            }
            
            
            
            
            
            
//            let realm = try! Realm()
//            let allTime: Int = realm.objects(Log.self).sum(ofProperty: "measurement")
//            let mean = allTime/mainInstance.logArrayCount
//            avgLabel.text = String(mean)
            

        }

    }
}

    




