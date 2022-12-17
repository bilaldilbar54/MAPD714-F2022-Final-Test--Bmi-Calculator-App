//  Final Test - BMI Calculator App
//  Author's name and StudentID:
//  Name: Muhammad Bilal Dilbar Hussain
//  Student ID: 301205152
//  Dated: 16/Dec/2022
//  App description: A BMI Calculator App
//  Xcode Version : Version 14.1 (14B47b)

import UIKit

class TrackingScreenViewController: UIViewController {

    //Outlet
    @IBOutlet weak var tableView: UITableView!
    
    var records: [BmiRecord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Fetching stored data
        records = AppDelegate.shared.record()
        //Reloading the tableView
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Fetching stored data
        records = AppDelegate.shared.record()
        //Reloading the tableView
        tableView.reloadData()
    }
}

extension TrackingScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    //Number of sections in tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return records.count
    }
    
    //Number of rows in each section of tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //Assigning values to each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! CustomTableViewCell
        let record = records[indexPath.section]
        cell.dateLabel.text = record.date
        cell.weightLabel.text = String(record.weight)
        cell.bmiLabel.text = String(record.bmiVal)
        
        cell.contentView.layer.borderWidth = 1
        
        return cell
    }
    
    //Performing Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "UpdateRecord") {
            let controller = segue.destination as! UpdateRecordViewController
            //controller.delegate = self
            controller.record = sender as? BmiRecord
        }
        
        if (segue.identifier == "Home") {
            let controller = segue.destination as! HomeScreenViewController
        }
    }
    
    //Swiping left to right method for update
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let update = UIContextualAction(style: .normal, title: "Update") {
            action, view , update in
            self.performSegue(withIdentifier: "UpdateRecord", sender:self.records[indexPath.section])
            update(false)
        }
        let image = UIImage(systemName: "square.and.pencil")
        update.image = image
        update.backgroundColor = .systemFill
        return UISwipeActionsConfiguration(actions: [update])
    }
    
    //Swiping right to left method for delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") {
            action, view , delete in
            let record = self.records[indexPath.section]
            AppDelegate.shared.deleteContext(item: record)
            AppDelegate.shared.saveContext()
            self.records = AppDelegate.shared.record()
            self.tableView.reloadData()
            if (self.records.isEmpty) {
                self.performSegue(withIdentifier: "Home", sender: self)
            }
            delete(false)
        }
        let image = UIImage(systemName: "trash.fill")
        delete.image = image
        return UISwipeActionsConfiguration(actions: [delete])
    }
}


