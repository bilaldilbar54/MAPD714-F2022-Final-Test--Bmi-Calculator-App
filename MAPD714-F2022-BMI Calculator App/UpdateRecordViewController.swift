//  Final Test - BMI Calculator App
//  Author's name and StudentID:
//  Name: Muhammad Bilal Dilbar Hussain
//  Student ID: 301205152
//  Dated: 16/Dec/2022
//  App description: A BMI Calculator App
//  Xcode Version : Version 14.1 (14B47b)

import UIKit

protocol UpdateRecordViewControllerDelegate {
    func updateRecordViewController(_ vc: UpdateRecordViewController)
}

class UpdateRecordViewController: UIViewController {
    
    //Outlet
    @IBOutlet weak var updateWeightText: UITextField!
    
    var record: BmiRecord?
    var delegate: UpdateRecordViewController?
    var date: String = ""
    var bmiVal: Double = 0.0
    var unitSwitchVal: String = ""
    var weight: Double = 0.0
    var height: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assigning unit value selected
        unitSwitchVal = (record?.unitSelected!)!
        //Assigning weight value selected
        updateWeightText.text = String(record!.weight)
        
        //Getting the current date & time
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        let dateString = formatter.string(from: now)
        date = dateString
    }
    
    //Update button pressed function
    @IBAction func updateButtonClicked(_ sender: UIButton) {
        if updateWeightText.text != "" {
            weight = Double(updateWeightText.text!)!
        }
        height = record!.height
        
        if (unitSwitchVal == "Metric") {
            //For Metric Calculation
            if (weight != 0.0 && height != 0.0) {
                let heightMtr = height / 100
                bmiVal = (weight) / (heightMtr * heightMtr)
                bmiVal = (ceil(bmiVal * 1000)) / 1000
                record?.weight = weight
                record?.date = date
                record?.bmiVal = bmiVal
            }
        } else {
            //For Imperial Calculation
            if (weight != 0.0 && height != 0.0) {
                bmiVal = ((weight * 703) / (height * height))
                bmiVal = (ceil(bmiVal * 1000)) / 1000
                record?.weight = weight
                record?.date = date
                record?.bmiVal = bmiVal
            }
            AppDelegate.shared.saveContext()
        }
    }
}
