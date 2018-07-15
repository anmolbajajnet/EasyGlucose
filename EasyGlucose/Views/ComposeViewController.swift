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
        let myGlucose = glucoseTextField.text!
       // if myGlucose?.isEmpty ?? true{
    //        emptyGlucoseAlert()
   //     } else  {
            print(myGlucose)
        // The if/else control here uses segment controler, should be changed for better method
        
        //logic: if beforemeal->save Log object, if aftermeal ->save afterMealLog object
        // this is temporary lazy code to get the graph working, please polish code later.
        if mealTimeToggle.isEnabled{
            let myLog = Log()
            myLog.note = myGlucose
            let realm = try! Realm() //create a realm object
            try! realm.write {       // write the object to swift
                realm.add(myLog)
            }
        }else{
            let myLog = afterMealLog()
            myLog.measurement = myGlucose
            let realm = try! Realm()
            try! realm.write{
                realm.add(myLog)
            }
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
