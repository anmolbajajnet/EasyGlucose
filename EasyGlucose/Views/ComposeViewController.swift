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
