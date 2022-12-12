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
    
    var weight: Float = 0.0
    var height: Float = 0.0
    var bmiVal: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weightField.text = "0.0"
        heightField.text = "0.0"
        unitSwitch.isOn = false
        bmiScoreField.text = ""
        bmiCategoryField.text = ""
    }
    
    func bmiCategory (bmiVal: Float) {
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
        
        weight = Float(weightField.text!)!
        height = Float(heightField.text!)!
        
        if (unitSwitch.isOn) {
            //Imperial Calculation
            bmiVal = ((weight) / (height * height)) * 703
            bmiScoreField.text = String(bmiVal)
            self.bmiCategory(bmiVal: bmiVal)
        } else {
            //Metric Calculation
            bmiVal = (weight) / (height * height)
            bmiScoreField.text = String(bmiVal)
            self.bmiCategory(bmiVal: bmiVal)
        }
    }
    
}

