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

    override func viewDidLoad() {
        super.viewDidLoad()
        drawDefaultChart()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var lineChartView: LineChartView!
    
//    @IBOutlet weak var lineChartView: LineChartView!
//
    func getBeforeMealLogsFromDB()->[Log]{
        let realm = try! Realm()
        let logs = realm.objects(Log.self)
        return logs.map({$0})
    }
    func getAfterMealLogsFromDB()->[afterMealLog]{
        let realm = try! Realm()
        let logs = realm.objects(afterMealLog.self)
        return logs.map({$0})
    }
    func drawDefaultChart(){
        let beforeMealLogs = getBeforeMealLogsFromDB()
        let afterMealLogs = getAfterMealLogsFromDB()
        let defaultDataCount = 6 // default graph show last 6 data points
        
        // NEED TO MAKE THIS A LIST OF TULES FOR VALUE AND DATE (USED FOR PLOTTING X AXIS)
        var beforeMealValues = [String]()
        var afterMealValues = [String]()
        

        for i in 0..<defaultDataCount{
            let beforeMealIndex = beforeMealLogs.count-i-1
            let afterMealIndex = afterMealLogs.count-i-1
            // logically equivalent to prepend
            beforeMealValues.insert(beforeMealLogs[beforeMealIndex].note, at:0)
            afterMealValues.insert(afterMealLogs[afterMealIndex].measurement, at:0)
        }
        
        print("#### PRINTING BEFORE MEAL VALUES FOR TESTING")
        for values in beforeMealValues{
            print(values)
        }
        print("#### PRINTING AFTER MEAL VALUES FOR TESTING")
        for values in afterMealValues{
            print(values)
        }
        
        // NEED TO CHANGE X AXIS FROM i TO TIME
        let values = (0..<defaultDataCount).map {(i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i), y: Double(beforeMealValues[i])!)
        }
        let values2 = (0..<defaultDataCount).map {(i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i), y: Double(afterMealValues[i])!)
        }

        let set1 = LineChartDataSet(values:values, label: "DataSet 1")
        let beforeMealColor = UIColor.red
        set1.setCircleColor(beforeMealColor)


        let set2 = LineChartDataSet(values:values2, label: "DataSet 2")
        set2.setCircleColor(UIColor.blue)
        let data = LineChartData(dataSets: [set1, set2])

        self.lineChartView.data = data
    }
    
}
