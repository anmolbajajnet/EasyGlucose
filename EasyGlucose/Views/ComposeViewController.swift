//
//  ComposeViewController.swift
//  EasyGlucose
//
//  Created by Anmol Bajaj on 2018-07-11.
//  Copyright © 2018 Glucinators. All rights reserved.
//

import UIKit
import RealmSwift

class ComposeViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var glucoseLabel: UILabel!
    
    @IBOutlet weak var imageLabel: UIButton!
    
    @IBOutlet weak var notesLabel: UILabel!
    
    @IBOutlet weak var carbsLabel: UILabel!
    
    @IBOutlet weak var bloodLabel: UILabel!
    
    @IBOutlet weak var logLabel: UIButton!
    
    @IBOutlet weak var backLabel: UIButton!
    
    
    //##### CODE FOR IMAGE SAVING / LOADING
    var logIncludeImage = false
    var imageURLToBeSaved:NSURL = NSURL()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func importImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
        {
            //After it is complete
        }

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        // the URL and boolean below will be used to save image URL
        imageURLToBeSaved = info[UIImagePickerControllerImageURL] as! NSURL
        logIncludeImage = true
        let imageURLInString = imageURLToBeSaved.path
        if let image = UIImage(contentsOfFile:imageURLInString!)
            //        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            imageView.image = image
        }
        else
        {
            print("ERROR LOAGIND FROM URL")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //##### END CODE FOR IMAGE SAVING / LOADING

    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var glucoseTextField: UITextField!
    @IBOutlet weak var moodTextField: UITextField!
    @IBOutlet weak var carbTextField: UITextField!
    @IBOutlet weak var bloodPressureTextField: UITextField!
    
    
    @IBOutlet weak var mealTimeToggle: UISegmentedControl!
    
   // The text property of a text label is an optional, you have to unwrap it before using it. ??
    @IBAction func logButton(_ sender: UIButton) {
        // TODO: Edge case checks, eg empty fields.
        // I skipped this so i can get things working first - Tony L.
        
        let myGlucose = glucoseTextField.text!
        
        if Int(myGlucose) != nil {
            let logToBeSaved = Log()
            // need to check for edge cases
            // maybe change the input method from storyboard
            logToBeSaved.measurement = Int(myGlucose)!
            if moodTextField.text != nil{
                logToBeSaved.note = moodTextField.text!
            }
            if bloodPressureTextField.text != nil {
                logToBeSaved.bloodPressureMeasurement = bloodPressureTextField.text!
            }
            if carbTextField.text != nil{
                logToBeSaved.carbMeasurement = carbTextField.text!
            }
            
            
            // saving image related info
            if logIncludeImage{
                logToBeSaved.imageURL = imageURLToBeSaved.path!
                logToBeSaved.hasPicture = true
                logIncludeImage = false
            }else{
                logToBeSaved.hasPicture = false
            }
            
            // TODO: "isEnabled" is not the right boolean for state of toggle, fix this
            if mealTimeToggle.selectedSegmentIndex == 0{
                logToBeSaved.timeInRelationToMeal = "Before meal"
                print("saved log for before meal")
            }else{
                logToBeSaved.timeInRelationToMeal = "After meal"
                print("saved log for after meal")
            }
            
            
            let realm = try! Realm()
            try! realm.write {
                print("Saving data")
                realm.add(logToBeSaved)
            }
        }else{
            emptyGlucoseAlert()
        }

    }
    
        


    
    // This funciton gets called and shows an alert when the glucose input is empty
    func emptyGlucoseAlert() {
        let alert = UIAlertController(title: "Made a mistake?", message: "Your glucose was left empty. Please enter your reading! :)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Log again", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        changeLang()
        
    }

    //A functoin that changes the language from the default English to simplified chinese
    func changeLang(){
        if (mainInstance.engLang) == false {
            glucoseLabel.text = "血糖"
            imageLabel.setTitle("添加图片", for: .normal)
            notesLabel.text = "添加备注"
            carbsLabel.text = "碳水"
            bloodLabel.text = "血压"
            logLabel.setTitle("记录", for: .normal)
            backLabel.setTitle("返回", for: .normal)
            mealTimeToggle.setTitle("饭前测量", forSegmentAt: 0)
            mealTimeToggle.setTitle("饭后测量", forSegmentAt: 1)
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
