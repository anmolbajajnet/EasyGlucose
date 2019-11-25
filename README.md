# EasyGlucose

Welcome! 

This is the initial documentation for our app. We will be documenting our classes and important functions in this readme.

<b>Video Demo: https://www.youtube.com/watch?v=L98STTfdX8c&frags=pl%2Cwn</b>

Please only push your code to this repo if it builds without any warnings or error. DO NOT push if the build fails.

Steps:

1) Pull to your local computer
2) Install cocoapods. Cocoa is Apple’s Application Programming Interface (API) for its operating system iOS and macOS. iOS applications rely on many Cocoa libraries to be fully functional. 
We plan to use the popular “Cocoa Dependency Manager” called CocoaPods. It’s a powerful tool
that “resolves dependencies between libraries, fetches source code for all dependencies, and
creates and maintains an Xcode workspace.”.
  - Locate the application folder from the Terminal
  - enter the 'pod install' command
  - always open the .xcworkspace file, NOT the .xcodeproj
3) Select iPhone SE as the phone model for the application works best on small screen, budget-friendly phone.

For Realm => https://realm.io/docs/swift/latest/ this is extremely helpful!

Functions: 

class MainInstance -> This is a global class where global variables are stored the class gets called using mainInstance
  - when mainInstance.engLang = false, the entire app is translated into Chinese
  
 A function that puts all the glucose values into an array
    func loadData()
    
A function that displays the log values into each cell

    override func tableView()

A function that saves the user intputs into the mainInstance class

    override func prepare()
    
A function that changes the language from the default english to simplified chinese

    func changeLang()

A function that displays all the user information from the database

    func fillProfile()

A function that calculates the average glucose, carbs, and blood pressure

    func avgCalculation()

This funciton gets called and shows an alert when the glucose input is empty

    func emptyGlucoseAlert() 
 
 Display the default chart displaying the glucose values

    func drawDefaultChart()
 
 
