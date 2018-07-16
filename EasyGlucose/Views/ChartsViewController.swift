//
//  ChartsViewController.swift
//  EasyGlucose
//
//  Created by Tony L on 2018-07-14.
//  Copyright © 2018 Glucinators. All rights reserved.
//

import UIKit
import Charts
import RealmSwift
class ChartsViewController: UIViewController {

    // draw the default graph upon loading
    override func viewDidLoad() {
        super.viewDidLoad()
        drawDefaultChart()
        // Do any additional setup after loading the view.
    }
    func drawDefaultChart(){
        drawChartByCount(dataCount:6)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    @IBAction func graphDataFor7Days(_ sender: UIButton) {
        let filteredData = grabDataForXDays(7)
        drawChartByGivenObjects(objects: filteredData!)
        // test for null?
    }
    @IBAction func graphDataFor30Days(_ sender: UIButton) {
        let filteredData = grabDataForXDays(30)
        drawChartByGivenObjects(objects: filteredData!)
    }
    @IBAction func graphDataFor90Days(_ sender: UIButton) {
        let filteredData = grabDataForXDays(90)
        drawChartByGivenObjects(objects: filteredData!)
    }

    @IBAction func graphAllData(_ sender: UIButton) {
    }
    
    // TODO: distinguish before meal and after meal values
    // function grabs reference of all 'Log' objects from the database
    func getMealLogsFromDB()->[Log]{
        let realm = try! Realm()
        let logs = realm.objects(Log.self)
        return logs.map({$0})
    }
    
    // Description:
    // Used for drawing the default graph
    // function will take the latest "dataCount" number of data points from DB and plot it on graph
    // this function should be removed later and replace the default graph with 7 or 30 days graph
    // current left here to use as reference for graph implementation
    func drawChartByCount(dataCount:Int){
        let mealLogs = getMealLogsFromDB()
        var logValues = [Int]()
        for i in 0..<dataCount{
            let indexForObjectArray = mealLogs.count-i-1
            logValues.insert(mealLogs[indexForObjectArray].measurement, at:0)
        }
        
        let values = (0..<dataCount).map {(i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i), y: Double(logValues[i]))
        }
        //        let values2 = (0..<dataCount).map {(i) -> ChartDataEntry in
        //            return ChartDataEntry(x: Double(i), y: Double(afterMealValues[i])!)
        //        }
        let set1 = LineChartDataSet(values:values, label: "DataSet 1")
        let beforeMealColor = UIColor.red
        set1.setCircleColor(beforeMealColor)
        
        //        let set2 = LineChartDataSet(values:values2, label: "DataSet 2")
        //        set2.setCircleColor(UIColor.blue)
        //        let data = LineChartData(dataSets: [set1, set2])
        
        let data = LineChartData(dataSet: set1)
        self.lineChartView.data = data
    }
    
    // return object array where data are in chronological order
    // latest data is in the first slot
    func grabDataForXDays(_ dayCount:Int)->[Log]?{
        let daysInSeconds = -86400 * dayCount
        let filterInputDate = Date.init(timeIntervalSinceNow: TimeInterval(daysInSeconds))
        let realm = try! Realm()
        let logs = realm.objects(Log.self).filter("timestamp >= %@", filterInputDate)
        return logs.map({$0})
        
    }
    
    // this function will take in a list of "Log" objects and produce a line graph using "measurement" property of each object in the list for the Y axis
    func drawChartByGivenObjects(objects:[Log]){
        var graphInputValues = [Int]()
        for i in 0..<objects.count{
            graphInputValues.insert(objects[i].measurement, at:0)
        }
        let values = (0..<objects.count).map {(i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i), y: Double(graphInputValues[i]))
        }
        let set1 = LineChartDataSet(values:values, label: "DataSet 1")
        let beforeMealColor = UIColor.red
        set1.setCircleColor(beforeMealColor)
        let data = LineChartData(dataSet: set1)
        self.lineChartView.data = data
        
    }
    
}
// code used to test filter function of realm

//print("testing filter, grabbing all values less than 200")
//let realm = try! Realm()
//let filteredValues = realm.objects(Log.self).filter("measurement<=150")
//for objects in filteredValues{
//    print(objects.measurement)
//    print(objects.timestamp)
//}


// run this loop somewhere to insert large amount of data in DB
// the loop will insert 20 data to DB, where each data point will have "timestamp" property i*2 days before time of insertion
// the ""measurement" for each field will also increment by 2 for each iteration

//        for i in 0..<20{
//            var sampleLog = Log()
//            sampleLog.timestamp = Date.init(timeIntervalSinceNow: Double(i) * -172800)
//            sampleLog.measurement = 150 + (2 * i)
//            sampleLog.note = "loop entry"
//            sampleLog.timeInRelationToMeal = "After meal"
//            let realm = try! Realm()
//            try! realm.write{
//                realm.add(sampleLog)
//            }
//        }

