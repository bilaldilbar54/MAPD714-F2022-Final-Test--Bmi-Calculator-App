//  Final Test - BMI Calculator App
//  Author's name and StudentID:
//  Name: Muhammad Bilal Dilbar Hussain
//  Student ID: 301205152
//  Dated: 16/Dec/2022
//  App description: A BMI Calculator App
//  Xcode Version : Version 14.1 (14B47b)

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var record: BmiRecord?
    
    func set(weight: String, bmi: String, date: String) {
        weightLabel.text = weight
        bmiLabel.text = bmi
        dateLabel.text = date
    }
    
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        self.delete()
        
    }
    
    func delete () {
        AppDelegate.shared.deleteContext(item: record!)
        print("Delete Done")
        AppDelegate.shared.saveContext()
    }
}
