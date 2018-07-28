//
//  ChartsViewController.swift
//  EasyGlucose
//
//  Created by Tony L on 2018-07-14.
//  Copyright © 2018 Glucinators. All rights reserved.
//

// README:
// Testing of retrieving data from database is done by pressing "all time" button on main story board
// change the naming of the button plz.
// the "all time" button calls "graphAllData" function.
// read description around testing section for more info

// TODO: (probably for next iteration)
// generalize the graph filters into 1 function activated by selection UI on main storyboard
// Implement x axis of graph accordingly to date of measurement
// Improve aesthetis of graph
// Filter data by tag
// add option to graph both "before meal" measurements and "after meal" measurements on the same graph
//      For reference on how to add multiple lines on a graph, see implementation of function "drawChartByCount"

import UIKit
import Charts
import RealmSwift
class ChartsViewController: UIViewController {

    // draw the default graph for data gathered in last 7 days upon loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawDefaultChart()
        
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var mealTimeFilterOption: UISegmentedControl!
    @IBOutlet weak var lineChartView: LineChartView!
    
    func drawDefaultChart(){
        let filteredData = grabDataForXDays(dayCount: 7)
        let sortedData = sortGrabbedData(grabbedData: filteredData)
        drawChartByGivenObjects(objects: sortedData)
    }
    
    @IBAction func graphDataFor7Days(_ sender: UIButton) {
        let filteredData = grabDataForXDays(dayCount: 7)
        let sortedData = sortGrabbedData(grabbedData: filteredData)
        drawChartByGivenObjects(objects: sortedData)
        // test for null?
    }
    @IBAction func graphDataFor30Days(_ sender: UIButton) {
        let filteredData = grabDataForXDays(dayCount: 30)
        let sortedData = sortGrabbedData(grabbedData: filteredData)
        drawChartByGivenObjects(objects: sortedData)
    }
    @IBAction func graphDataFor90Days(_ sender: UIButton) {
        let filteredData = grabDataForXDays(dayCount: 90)
        let sortedData = sortGrabbedData(grabbedData: filteredData)
        drawChartByGivenObjects(objects: sortedData)
    }


    //#####################
    //## TESTING FUNCTIONS
    //#####################
    
    // How it works:
    // Testing of plotted graph is done by manually opening the simulator and inspecting the plotted values
    // edge cases of no data in DB is also tested by manually opening the simulator
    
    // data insertion/filter/sort testing:
    // call test function by pressing "all time" button on the graph view screen
    // 20 Log values with scrambled "timestamp" value will be inserted
    // number can be modified by changing "datacount:val" @insertDataWithScrambledDate()
    // all test Log values will have "usedForTesting" property set to "true"
    
    // filter tested tested by manually inspecting results printed to console
    
    // sort order function is automatically tested
    
    // all test Log values will be deleted at the end of testing
    // to keep the test log values, comment out "deleteTestingValues()" located around the lines printing information

    func insertDataWithScrambledDate(dataCount:Int){
        for i in 0..<dataCount{
            let sampleLog = Log()
            let random = Int(arc4random_uniform(10))
            sampleLog.timestamp = Date.init(timeIntervalSinceNow: Double(i+random) * -172800)
            sampleLog.measurement = 150 + (2 * i)
            sampleLog.note = "loop entry"
            if i%2 == 0 {
                sampleLog.timeInRelationToMeal = "Before meal"
            }else{
                sampleLog.timeInRelationToMeal = "After meal"
            }
            
            sampleLog.usedForTesting = true
            let realm = try! Realm()
            try! realm.write{
                realm.add(sampleLog)
            }
        }
    }
    func deleteTestingValues(){
        let realm = try! Realm()
        let testDataToDelete = realm.objects(Log.self).filter("usedForTesting == true")
        try! realm.write({
            realm.delete(testDataToDelete)
        })
    }
    
    @IBAction func graphAllData(_ sender: UIButton) {
        // testing filter function
        // manually inspect printed result to verify that returned data is not sorted by date
        insertDataWithScrambledDate(dataCount: 20)
        let returnedData = grabDataForXDays(dayCount: 200)
        var testDataCount = 0
        var originalDataCount = 0
        
        print("#### PRINTING UNSORTED DATA, PLEASE VERIFY THAT TIMESTAMP IS NOT SORTED")
        for object in returnedData{
            if object.usedForTesting == true{
                testDataCount += 1
            }else{
                originalDataCount += 1
            }
            print(object.timestamp)
        }
        
        // testing sort function
        let sortedData = sortGrabbedData(grabbedData: returnedData)
        var outOfOrderFlag = false
        var previousObject = Log()
        for i in 0..<sortedData.count{
            if i > 0{
                previousObject = sortedData[i-1]
                if previousObject.timestamp < sortedData[i].timestamp{
                    print("comparison failed")
                    outOfOrderFlag = true
                }
            }
        }
        print("")
        print("#### PRINTING TEST RESULT ####")
        print("Number of test data gathered: \(testDataCount)")
        print("Number of data gathered that are originally present in DB: \(originalDataCount)")
        if(outOfOrderFlag){
            print("Sort function result: SORT FAILED")
        }else{
            print("Sort function result: SORT SUCCEEDED")
        }
        print("#### END OF TEST RESULTS ####")
        print("Deleting all testing data inserted into DB... ... ...")
        // deleteTestingValues()       // comment out to keep testing values
        print("Test data points deleted")
    }
    
    //######### END TESTING ##########
    
    // Function Description: grabs reference of all 'Log' objects from the database
    // move this to Log.swift later
    func getMealLogsFromDB()->[Log]{
        let realm = try! Realm()
        let logs = realm.objects(Log.self)
        return logs.map({$0})
    }
    

    // Function description:
    // return realm object list of "Log" containing data points with timestamp within past X days respective to present time
    // returned array is ordered by time of insertion, which is not equivalent of being sorted by timestamp
    // latest data is in the first slot of the list
    func grabDataForXDays(dayCount:Int)->Results<Log>{
        let daysInSeconds = -86400 * dayCount
        let filterInputDate = Date.init(timeIntervalSinceNow: TimeInterval(daysInSeconds))
        let realm = try! Realm()
        let logs = realm.objects(Log.self).filter("timestamp >= %@", filterInputDate)
        return logs
    }
    
    // Function description: sort data grabbed by "grabDataForXDays" function
    func sortGrabbedData(grabbedData:Results<Log>)->[Log]{
        let sortedLog = grabbedData.sorted(byKeyPath: "timestamp", ascending: false)
        return sortedLog.map({$0})
    }
    
    // this function will take in a list of "Log" objects and produce a line graph using "measurement" property of each object in the list for the Y axis
    func drawChartByGivenObjects(objects:[Log]){
        var fillCount = 0
        if mealTimeFilterOption.selectedSegmentIndex != 2{
            var graphInputValues = [Int]()
            for i in 0..<objects.count{
                if mealTimeFilterOption.selectedSegmentIndex == 0{
                    if objects[i].timeInRelationToMeal == "Before meal"{
                        graphInputValues.insert(objects[i].measurement, at:0)
                        fillCount += 1
                    }
                }else{
                    if objects[i].timeInRelationToMeal == "After meal"{
                        graphInputValues.insert(objects[i].measurement, at:0)
                        fillCount += 1
                    }
                }
                
            }
            let values = (0..<fillCount).map {(i) -> ChartDataEntry in
                return ChartDataEntry(x: Double(i), y: Double(graphInputValues[i]))
            }
            var graphLabel = ""
            if mealTimeFilterOption.selectedSegmentIndex == 0{
                graphLabel = "Before meal measurements"
            }else{
                graphLabel = "After meal measurements"
            }
            let set1 = LineChartDataSet(values:values, label: graphLabel)
            
            let beforeMealColor = UIColor.red
            set1.setCircleColor(beforeMealColor)
            let data = LineChartData(dataSet: set1)
            self.lineChartView.data = data
        }else{
            var beforeMealValues = [Int]()
            var afterMealValues = [Int]()
            // categorizing data into 2 sets
            for i in 0..<objects.count {
                if objects[i].timeInRelationToMeal == "Before meal"{
                    beforeMealValues.insert(objects[i].measurement, at:0)
                }else{
                    afterMealValues.insert(objects[i].measurement, at:0)
                }
            }
            // draw chart using categorized data
            let values = (0..<beforeMealValues.count).map {(i) -> ChartDataEntry in
                return ChartDataEntry(x: Double(i), y: Double(beforeMealValues[i]))
            }
            let values2 = (0..<afterMealValues.count).map {(i) -> ChartDataEntry in
                return ChartDataEntry(x: Double(i), y: Double(afterMealValues[i]))
            }
            let set1 = LineChartDataSet(values:values, label: "Before meal measurements")
            let beforeMealColor = UIColor.red
            set1.setCircleColor(beforeMealColor)
            set1.setColor(beforeMealColor)
            
            let set2 = LineChartDataSet(values:values2, label: "After meal measurements")
            set2.setCircleColor(UIColor.blue)
            let data = LineChartData(dataSets: [set1, set2])
            self.lineChartView.data = data
            
        }
        
    }
    
    // this function is not actually used in program, remove at the end
    // current left here to use as reference for graph implementation
    // Description:
    // function will take the latest "dataCount" number of data points from DB and plot it on graph
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
    
}

// ### other reference codes ###

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

