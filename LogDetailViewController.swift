//
//  LogDetailViewController.swift
//  
//
//  Created by Anmol Bajaj on 2018-07-16.
//

import UIKit

class LogDetailViewController: UIViewController {


    @IBOutlet weak var glucoseDisplay: UILabel!

    @IBOutlet weak var imageDisplay: UIImageView!
    
    @IBOutlet weak var rangeDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

          navigationItem.largeTitleDisplayMode = .never
        
        glucoseDisplay.text = String(mainInstance.glucose)
        print(mainInstance.glucose)
        
     
        // 5 is just a random value. research appropriate vals to show appropriate messages.
        if (mainInstance.glucose > 5) {
              rangeDisplay.text = "You are within range!"
        } else {
            rangeDisplay.text = "You are not within range. :("
        }
        
        //loading image if the log has image included
        if mainInstance.hasPicture{
            let imageURL = mainInstance.imageURL
            if let image = UIImage(contentsOfFile:imageURL)
            {
                imageDisplay.image = image
            }
            else
            {
                print(imageURL)
                print("ERROR LOAGIND FROM URL")
                //Error message
            }
        }else{
            imageDisplay = nil
        }

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
