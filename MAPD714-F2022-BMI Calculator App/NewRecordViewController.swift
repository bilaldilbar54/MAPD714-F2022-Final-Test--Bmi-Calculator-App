//  Final Test - BMI Calculator App
//  Author's name and StudentID:
//  Name: Muhammad Bilal Dilbar Hussain
//  Student ID: 301205152
//  Dated: 16/Dec/2022
//  App description: A BMI Calculator App
//  Xcode Version : Version 14.1 (14B47b)

import UIKit

class NewRecordViewController: UIViewController {
    
    @IBOutlet weak var newWeightTextField: UITextField!
    @IBOutlet weak var newHeightTextField: UITextField!
    
    var records: [BmiRecord] = []
    var weight: Double = 0.0
    var height: Double = 0.0
    var date: String = ""
    var bmiVal: Double = 0.0
    var unitSwitchVal: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        records = AppDelegate.shared.record()
        
        newHeightTextField.text = "0.0"
        newWeightTextField.text = "0.0"
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: now)
        date = dateString
        
        //let record = records[IndexPath.section]
        //unitSwitchVal = record.unitSelected

    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
    }
    
}
