//
//  ComposeViewController.swift
//  EasyGlucose
//
//  Created by Anmol Bajaj on 2018-07-11.
//  Copyright © 2018 Glucinators. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var glucoseTextField: UITextField!
    
    @IBAction func logButton(_ sender: UIButton) {
        let myGlucose = glucoseTextField.text
        if myGlucose?.isEmpty ?? true{
            print("Alert popup displaying that textfield is empty")
            let alert = UIAlertController(title: "Made a mistake?", message: "Your glucose was left empty. Please enter your reading! :)", preferredStyle: .alert)
            let action = UIAlertAction(title: "Log again", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        } else  {
            print(myGlucose)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
