//
//  TasksListPresenter.swift
//  TODO MVP
//
//  Created by Sylvan Ash on 30/07/2018.
//  Copyright © 2018 Sylvan Ash. All rights reserved.
//

import Foundation

protocol TasksListDelegate: class {
    func showProgress()
    func hideProgress()
    func setTasks(_ tasks: [Task])
    func setEmptyTasks()
    func showError(error: Error)
}

class TasksListPresenter {
    weak internal var delegate: TasksListDelegate?
    fileprivate let service: TaskService
    
    init(view: TasksListDelegate, service: TaskService = TaskService()) {
        self.delegate = view
        self.service = service
    }

    func setDelegate(_ delegate: TasksListDelegate) {
        self.delegate = delegate
    }
    
    func fetchTasks() {
        // display loading indicator
        delegate?.showProgress()
        
        service.getTasks { [weak self] tasks, error in
            
            // hide loading indicator
            self?.delegate?.hideProgress()
            
            // error
            guard error == nil else {
                self?.delegate?.showError(error: error!)
                return
            }
            
            if tasks.count == 0 {
                self?.delegate?.setEmptyTasks()
                
            } else {
                // to map or not to map?
                // let mappedTasks = tasks.mapToViewData
                
                self?.delegate?.setTasks(tasks)
            }
        }
    }
    
}
