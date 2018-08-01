//
//  TasksListPresenter.swift
//  TODO MVP
//
//  Created by Sylvan Ash on 30/07/2018.
//  Copyright © 2018 Sylvan Ash. All rights reserved.
//

import Foundation

protocol TasksListDelegate: NSObjectProtocol {
    func showProgress()
    func hideProgress()
    func setTasks(_ tasks: [Task])
    func setEmptyTasks()
    func showError(error: Error)
}

class TasksListPresenter {
    weak fileprivate var delegate: TasksListDelegate?
    fileprivate let service: TaskService
    
    init(service: TaskService) {
        self.service = service
    }

    func setDelegate(_ delegate: TasksListDelegate) {
        self.delegate = delegate
    }
    
    func fetchTasks() {
        // display loading indicator
        delegate?.showProgress()
        
        service.getTasks { [weak self] tasks in
            
            // hide loading indicator
            self?.delegate?.hideProgress()
            
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
