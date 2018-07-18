//
//  ComposeViewController.swift
//  EasyGlucose
//
//  Created by Anmol Bajaj on 2018-07-11.
//  Copyright © 2018 Glucinators. All rights reserved.
//

import UIKit
import RealmSwift

class ComposeViewController: UIViewController {

    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var glucoseTextField: UITextField!
    @IBOutlet weak var moodTextField: UITextField!
    
    
    @IBOutlet weak var mealTimeToggle: UISegmentedControl!
    
   // The text property of a text label is an optional, you have to unwrap it before using it. ??
    @IBAction func logButton(_ sender: UIButton) {
        // TODO: Edge case checks, eg empty fields.
        // I skipped this so i can get things working first - Tony L.
        
        let myGlucose = glucoseTextField.text!
        let logToBeSaved = Log()
        // need to check for edge cases
        // maybe change the input method from storyboard
        logToBeSaved.measurement = Int(myGlucose)!
        logToBeSaved.note = moodTextField.text!
        // add input methods for other fields here
        
        // TODO: "isEnabled" is not the right boolean for state of toggle, fix this
        if mealTimeToggle.isEnabled{
            logToBeSaved.timeInRelationToMeal = "Before meal"
        }else{
            logToBeSaved.timeInRelationToMeal = "After meal"
        }
        print("printing info from log to be saved")
        print(logToBeSaved.measurement)
        print(logToBeSaved.note)
        print(logToBeSaved.timeInRelationToMeal)
        
        // TODO: generalize this as a function taking in a Object type
        let realm = try! Realm()
        try! realm.write {
            print("Saving data")
            realm.add(logToBeSaved)
        }
    }
    
        


    
    // ignore this for now
    func emptyGlucoseAlert() {
        let alert = UIAlertController(title: "Made a mistake?", message: "Your glucose was left empty. Please enter your reading! :)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Log again", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
