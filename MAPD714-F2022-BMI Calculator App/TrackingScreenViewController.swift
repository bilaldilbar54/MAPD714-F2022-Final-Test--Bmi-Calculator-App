//  Final Test - BMI Calculator App
//  Author's name and StudentID:
//  Name: Muhammad Bilal Dilbar Hussain
//  Student ID: 301205152
//  Dated: 16/Dec/2022
//  App description: A BMI Calculator App
//  Xcode Version : Version 14.1 (14B47b)

import UIKit

class TrackingScreenViewController: UIViewController {
    
    var records: [BmiRecord] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        backgroundView.backgroundColor = UIColor.cyan
            self.tableView.backgroundView = backgroundView
        records = AppDelegate.shared.record()
        tableView.reloadData()
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let record = self.records[indexPath.section]
            AppDelegate.shared.deleteContext(item: record)
            print("Delete Done")
            AppDelegate.shared.saveContext()
            self.records = AppDelegate.shared.record()
            self.tableView.reloadData()
        }
    }
}

extension TrackingScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! CustomTableViewCell
        let record = records[indexPath.section]
        cell.weightLabel.text = String(record.weight)
        cell.bmiLabel.text = "35"
        cell.dateLabel.text = record.date
        
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.borderWidth = 1
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        backgroundView.backgroundColor = UIColor.cyan
        cell.backgroundView = backgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Deleted") {
            action, view , delete in
            let record = self.records[indexPath.section]
            AppDelegate.shared.deleteContext(item: record)
            print("Delete Done")
            AppDelegate.shared.saveContext()
            self.records = AppDelegate.shared.record()
            self.tableView.reloadData()
            delete(false)
        }
        delete.backgroundColor = UIColor(red: 1, green: 0,  blue: 0, alpha: 1)
        return UISwipeActionsConfiguration(actions: [delete])
    }
}


