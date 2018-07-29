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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        avgCalculation()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func avgCalculation() {
        let realm = try! Realm()
        let allTime: Int = realm.objects(Log.self).sum(ofProperty: "measurement")
        let mean = allTime/mainInstance.logArrayCount
        avgLabel.text = String(mean)
    }
    



}
