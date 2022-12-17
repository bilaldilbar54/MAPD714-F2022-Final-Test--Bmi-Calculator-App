//  Final Test - BMI Calculator App
//  Author's name and StudentID:
//  Name: Muhammad Bilal Dilbar Hussain
//  Student ID: 301205152
//  Dated: 16/Dec/2022
//  App description: A BMI Calculator App
//  Xcode Version : Version 14.1 (14B47b)

import UIKit

class NewRecordViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var newWeightTextField: UITextField!
    @IBOutlet weak var newHeightTextField: UITextField!
    @IBOutlet weak var newUnitSwitch: UISwitch!
    
    var records: [BmiRecord] = []
    var weight: Double = 0.0
    var height: Double = 0.0
    var date: String = ""
    var bmiVal: Double = 0.0
    var unitSwitchVal: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        records = AppDelegate.shared.record()
        //Setting the switch to off at startup
        newUnitSwitch.isOn = false
        
        //Getting the current date & time
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        let dateString = formatter.string(from: now)
        date = dateString
    }
    
    //Function checking if the value of switch is changed
    @IBAction func newUnitSwitchValueChanged(_ sender: UISwitch) {
        if (!newUnitSwitch.isOn) {
            newWeightTextField.attributedPlaceholder = NSAttributedString(string: "Weight in Kg")
            newHeightTextField.attributedPlaceholder = NSAttributedString(string: "Height in Cm")
        } else {
            newWeightTextField.attributedPlaceholder = NSAttributedString(string: "Weight in Lbs")
            newHeightTextField.attributedPlaceholder = NSAttributedString(string: "Height in Inches")
        }
    }
    
    //Submit button pressed function
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        if newWeightTextField.text != "" {
            weight = Double(newWeightTextField.text!)!
        }
        
        if newHeightTextField.text != "" {
            height = Double(newHeightTextField.text!)!
        }
        
        if (newUnitSwitch.isOn) {
            //Imperial Calculation
            unitSwitchVal = "Imperial"
            if (weight != 0.0 && height != 0.0) {
                bmiVal = ((weight * 703) / (height * height))
                bmiVal = (ceil(bmiVal * 1000)) / 1000
            }
        } else {
            //Metric Calculation
            unitSwitchVal = "Metric"
            if (weight != 0.0 && height != 0.0) {
                let heightMtr = height / 100
                bmiVal = (weight / (heightMtr * heightMtr))
                bmiVal = (ceil(bmiVal * 1000)) / 1000
            }
        }
            
        //Appending the new record to the core data
        let record = AppDelegate.shared.bmiNew(weight: weight, height: height, date: date, bmiVal: bmiVal, unitSelected: unitSwitchVal)
        records.append(record)
        AppDelegate.shared.saveContext()
    }
}
