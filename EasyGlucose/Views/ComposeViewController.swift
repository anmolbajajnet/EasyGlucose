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
    
   // The text property of a text label is an optional, you have to unwrap it before using it. ??
    @IBAction func logButton(_ sender: UIButton) {
        let myGlucose = glucoseTextField.text!
       // if myGlucose?.isEmpty ?? true{
    //        emptyGlucoseAlert()
   //     } else  {
            print(myGlucose)
            let myLog = Log()
            myLog.note = myGlucose
            let realm = try! Realm()
            try! realm.write {
                realm.add(myLog)
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
