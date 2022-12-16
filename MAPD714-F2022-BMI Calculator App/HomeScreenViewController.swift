//  Final Test - BMI Calculator App
//  Author's name and StudentID:
//  Name: Muhammad Bilal Dilbar Hussain
//  Student ID: 301205152
//  Dated: 16/Dec/2022
//  App description: A BMI Calculator App
//  Xcode Version : Version 14.1 (14B47b)

import UIKit

class HomeScreenViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var unitSwitch: UISwitch!
    @IBOutlet weak var bmiScoreField: UILabel!
    @IBOutlet weak var bmiCategoryField: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    
    var records: [BmiRecord] = []
    //var weight: Double = 0.0
    //var height: Double = 0.0
    var bmiVal: Double = 0.0
    var date: String = ""
    var unitSwitchVal: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        unitSwitch.isOn = false
        bmiScoreField.text = ""
        bmiCategoryField.text = ""
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        let dateString = formatter.string(from: now)
        date = dateString
        
    }
    
    func bmiCategory (bmiVal: Double) {
        if (bmiVal < 16) {
            bmiCategoryField.text = "Severe Thinness"
        } else if (bmiVal >= 16 && bmiVal < 17) {
            bmiCategoryField.text = "Moderate Thinness"
        } else if (bmiVal >= 17 && bmiVal < 18.5) {
            bmiCategoryField.text = "Mild Thinness"
        } else if (bmiVal >= 18.5 && bmiVal < 25) {
            bmiCategoryField.text = "Normal"
        } else if (bmiVal >= 25 && bmiVal < 30) {
            bmiCategoryField.text = "Overweight"
        } else if (bmiVal >= 30 && bmiVal < 35) {
            bmiCategoryField.text = "Obese Class I"
        } else if (bmiVal >= 35 && bmiVal < 40) {
            bmiCategoryField.text = "Obese Class II"
        } else if (bmiVal > 40) {
            bmiCategoryField.text = "Obese Class III"
        }
    }
    

    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        
        guard let weight = weightField.text else {
            return
        }
        guard let height = heightField.text else {
            return
        }
        
        if (unitSwitch.isOn) {
            //Imperial Calculation
            unitSwitchVal = "Imperial"
            if (Double(weight) != 0.0 && Double(height) != 0.0) {
                bmiVal = ((Double(weight)! / (Double(height)! * Double(height)!))) * 703
                bmiScoreField.text = String(bmiVal)
                self.bmiCategory(bmiVal: bmiVal)
            }
        } else {
            //Metric Calculation
            unitSwitchVal = "Metric"
            if (Double(weight) != 0.0 && Double(height) != 0.0) {
                bmiVal = Double(weight)! / (Double(height)! * Double(height)!)
                bmiScoreField.text = String(bmiVal)
                self.bmiCategory(bmiVal: bmiVal)
            }
        }
        
        let record = AppDelegate.shared.bmi(name: nameField.text!, age: Int16(ageField.text!)!, gender: genderField.text!, weight: Double(weightField.text!)!, height: Double(heightField.text!)!, date: date, unitSelected: unitSwitchVal, bmiVal: bmiVal)
        records.append(record)
        AppDelegate.shared.saveContext()
    }
}

