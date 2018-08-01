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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    fileprivate var tasks: [Task] = []
    fileprivate var presenter: TasksListPresenter = TasksListPresenter(service: TaskService())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // title
        title = "Tasks List"
        
        activityIndicator?.hidesWhenStopped = true
        
        presenter.setDelegate(self)
        presenter.fetchTasks()
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let task = tasks[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TaskCellView
        cell.titleLabel.text = task.title
        cell.isCompletedImageView.image = task.isCompleted ? #imageLiteral(resourceName: "Icons/Checked Circle") : #imageLiteral(resourceName: "Icons/Circle")

        return cell
    }

}


extension TasksListTableViewController: TasksListDelegate {
    
    func showProgress() {
        activityIndicator?.startAnimating()
    }
    
    func hideProgress() {
        activityIndicator?.stopAnimating()
    }
    
    func setTasks(_ tasks: [Task]) {
        self.tasks = tasks
        tableView.reloadData()
    }
    
    func setEmptyTasks() {
        //
    }
    
    func showError(error: Error) {
        //
    }
    
}
