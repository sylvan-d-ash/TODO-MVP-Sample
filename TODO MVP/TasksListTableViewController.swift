//
//  TasksListTableViewController.swift
//  TODO MVP
//
//  Created by Sylvan Ash on 30/07/2018.
//  Copyright © 2018 Sylvan Ash. All rights reserved.
//

import UIKit

class TaskCellView: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isCompletedImageView: UIImageView!
}

class TasksListTableViewController: UITableViewController {
    
    fileprivate var tasks: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Tasks List"

        tasks.append(Task(title: "Make TODO MVP app"))
        tasks.append(Task(title: "Do you say you love me?"))
        tasks.append(Task(title: "Lately I'm falling down!"))
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TaskCellView
        cell.titleLabel.text = task.title
        cell.isCompletedImageView.image = task.isCompleted ? #imageLiteral(resourceName: "Icons/Checked Circle") : #imageLiteral(resourceName: "Icons/Circle")

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
