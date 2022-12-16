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
        cell.bmiLabel.text = String(record.bmiVal)
        cell.dateLabel.text = record.date
        
        cell.contentView.layer.borderWidth = 1
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if  segue.identifier == "EditItem"
        {
            let controller = segue.destination as! UpdateRecordViewController
            //controller.delegate = self
            controller.record = sender as? BmiRecord
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let update = UIContextualAction(style: .normal, title: "Update")
        {
            action, view , update in
            print("Update")
            self.performSegue(withIdentifier: "EditItem", sender:self.records[indexPath.section])
            update(false)
        }
        let image = UIImage(systemName: "square.and.pencil")
        update.image = image
        update.backgroundColor = .systemFill
        return UISwipeActionsConfiguration(actions: [update])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") {
            action, view , delete in
            let record = self.records[indexPath.section]
            AppDelegate.shared.deleteContext(item: record)
            print("Delete Done")
            AppDelegate.shared.saveContext()
            self.records = AppDelegate.shared.record()
            self.tableView.reloadData()
            delete(false)
        }
        let image = UIImage(systemName: "trash.fill")
        delete.image = image
        return UISwipeActionsConfiguration(actions: [delete])
    }
}


