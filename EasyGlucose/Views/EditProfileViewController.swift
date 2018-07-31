//
//  EditProfileViewController.swift
//
//
//  Created by Anmol Bajaj on 2018-07-30.
//

import UIKit
import RealmSwift

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var diabetesType: UISegmentedControl!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var practitionerEmail: UITextField!
    
    
    @IBOutlet weak var editLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var saveLabel: UIButton!
    
    
    @IBAction func saveProfile(_ sender: Any) {
        // delete previous profile
        deletePreviousProfile()
        // saving profile
        let profileToBeSaved = Profile()
        
        if diabetesType.selectedSegmentIndex == 0{
            profileToBeSaved.diabetesType = "Type 1"
        }else if diabetesType.selectedSegmentIndex == 1{
            profileToBeSaved.diabetesType = "Type 2"
        }else{
            profileToBeSaved.diabetesType = "Gestational"
        }
        
        if practitionerEmail.text != nil{
            profileToBeSaved.practitionerEmail = practitionerEmail.text!
        }
        if userName.text != nil {
            profileToBeSaved.userName = userName.text!
        }
        if userEmail.text != nil {
            profileToBeSaved.userEmail = userEmail.text!
        }
        let realm = try! Realm()
        try! realm.write {
            print("Saving data")
            realm.add(profileToBeSaved)
        }
    }
    
    
    func deletePreviousProfile(){
        let realm = try! Realm()
        let testDataToDelete = realm.objects(Profile.self)
        try! realm.write({
            realm.delete(testDataToDelete)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        changeLang()
        
        
        
    }
    //A function that changes the language from the default english to simplified chinese
    func changeLang(){
        if (mainInstance.engLang) == false {
        editLabel.text = "编辑资料"
        nameLabel.text = "姓名"
        typeLabel.text = "糖尿病类型"
        emailLabel.text = "你的邮箱"
        healthLabel.text = "医生邮箱"
        saveLabel.setTitle("保存资料", for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
