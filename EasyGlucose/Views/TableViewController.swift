//
//  TableViewController.swift
//  EasyGlucose
//
//  Created by Anmol Bajaj on 2018-07-12.
//  Copyright © 2018 Glucinators. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var logArray = [Log]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        loadData()

    }
    
    func loadData() {
        if let logs = LogsManager.shared.getLogs() {
            logArray = logs
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        mainInstance.logArrayCount = logArray.count
        return logArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let log = logArray[indexPath.row]
        
        cell.textLabel?.text = String(log.measurement)
        return cell

    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // Delete the row from the data source
        if editingStyle == .delete {
            let measurementObjectToDelete = logArray[indexPath.row]
            LogsManager.shared.deleteLog(measurementObjectToDelete)
            logArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let selectedLogIndexPath = self.tableView.indexPathForSelectedRow {
            let selectedLog = logArray[selectedLogIndexPath.row]
            let logVC = segue.destination as! LogDetailViewController
            mainInstance.glucose = selectedLog.measurement
            mainInstance.imageURL = selectedLog.imageURL
            mainInstance.hasPicture = selectedLog.hasPicture
            mainInstance.logDate =  selectedLog.timestamp
            mainInstance.carbMeasure = selectedLog.carbMeasurement
        
        }
        
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
