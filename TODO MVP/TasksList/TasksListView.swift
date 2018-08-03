//
//  TasksListViewController.swift
//  TODO MVP
//
//  Created by Sylvan Ash on 01/08/2018.
//  Copyright © 2018 Sylvan Ash. All rights reserved.
//

import UIKit

class TasksListView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    @IBOutlet weak var emptyView: UIView?
    
    fileprivate var tasks = [Task]()
    internal var presenter: TasksListPresenter?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        presenter = TasksListPresenter(view: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // title
        title = NSLocalizedString("Title_TasksList", comment: "Scene title")
        
        //presenter = TasksListPresenter(view: self)
        presenter?.fetchTasks()
    }

    @IBAction func buttonAddTaskDidTap(_ sender: Any) {
        
    }
    
}


extension TasksListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let task = tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TaskCellView
        
        cell.titleLabel.text = task.title
        cell.isCompletedImageView.image = task.isCompleted ? #imageLiteral(resourceName: "Icons/Checked Circle") : #imageLiteral(resourceName: "Icons/Circle")
        
        return cell
    }
    
    // enable editing
    
}


extension TasksListView: TasksListDelegate {
    
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
        emptyView?.isHidden = false
        tableView.isHidden = true
    }
    
    func showError(error: Error) {
        // views
        emptyView?.isHidden = false
        tableView.isHidden = true
        
        // show error
    }
    
}
