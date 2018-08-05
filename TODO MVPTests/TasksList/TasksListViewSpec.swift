//
//  TasksListViewSpec.swift
//  TODO MVPUITests
//
//  Created by Sylvan Ash on 01/08/2018.
//  Copyright © 2018 Sylvan Ash. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import TODO_MVP

class TasksListViewSpec: QuickSpec {
    
    class FakeTasksListPresenter: TasksListPresenter {
        var isLoading: Bool = false
        var isComplete: Bool = false
        var tasks: [Task] = []
        var error: Error? = nil

        override func fetchTasks() {
            if isLoading {
                delegate?.showProgress()
            }
            if isComplete {
                delegate?.hideProgress()

                if tasks.count == 0 {
                    delegate?.setEmptyTasks()
                } else {
                    delegate?.setTasks(tasks)
                }
            }
            if error != nil {
                delegate?.showError(error: error!)
            }
        }
    }
    
    private var presenter: FakeTasksListPresenter!
    var sut: TasksListView!
    
    override func spec() {
        describe("TasksListView") {
            beforeEach {
                self.sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TasksListSID") as! TasksListView
                self.presenter = FakeTasksListPresenter(view: self.sut)
                
                self.sut.presenter = self.presenter
                _ = self.sut.view
            }
            
            describe("fetching tasks") {
                context("when fetching tasks") {
                    it("should show activity indicator") {
                        // given
                        self.presenter.isLoading = true

                        // when
                        self.presenter.fetchTasks()

                        // then
                        expect(self.sut.activityIndicator).toNot(beNil())
                        expect(self.sut.activityIndicator?.isAnimating).to(equal(true))
                    }
                }

                context("when tasks have been fetched") {
                    it("should hide activity indicator") {
                        // given
                        self.presenter.isLoading = true
                        
                        // when
                        self.presenter.fetchTasks()
                        
                        // then
                        expect(self.sut.activityIndicator).toNot(beNil())
                        expect(self.sut.activityIndicator?.isAnimating).to(equal(true))
                        
                        // when
                        self.presenter.isLoading = false
                        self.presenter.isComplete = true
                        self.presenter.fetchTasks()
                        
                        // then
                        expect(self.sut.activityIndicator?.isAnimating).to(equal(false))
                    }
                    
                    it("should have 2 tasks loaded") {
                        // given
                        self.presenter.isComplete = true
                        self.presenter.tasks = [Task(title: "First"), Task(title: "Second")]

                        // when
                        self.presenter.fetchTasks()

                        // then
                        expect(self.sut.tableView.numberOfRows(inSection: 0)).to(equal(2))
                        
                        expect(self.sut.tableView.isHidden).to(equal(false))
                        expect(self.sut.emptyView?.isHidden).to(equal(true))
                    }
                    it("should show the NO TASKS view") {
                        // given
                        self.presenter.isComplete = true
                        
                        // when
                        self.presenter.fetchTasks()
                        
                        // then
                        expect(self.sut.emptyView?.isHidden).to(equal(false))
                        expect(self.sut.tableView.isHidden).to(equal(true))
                    }
                    it("should show an error alert message") {
                        // given
                        self.presenter.isComplete = true
                        self.presenter.error = NetworkError.IncorrectDataReturned
                        
                        // when
                        self.presenter.fetchTasks()
                        
                        // then
                        // validate that an error alert is shown
                        fail()
                    }
                }
            }

            describe("showing tasks") {
                context("table view cell") {
                    var cell: TaskCellView!
                    
                    it("should show unchecked icon and task title") {
                        // given
                        let title = "First"
                        self.presenter.isComplete = true
                        self.presenter.tasks = [Task(title: title), Task(title: "Second")]
                        
                        // when
                        self.presenter.fetchTasks()
                        cell = self.sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TaskCellView
                        
                        // then
                        expect(cell.titleLabel.text).to(equal(title))
                        expect(cell.isCompletedImageView.image).to(equal(#imageLiteral(resourceName: "Icons/Circle")))
                    }
                    it("should show checked icon and task title") {
                        // given
                        let title = "First cell"
                        self.presenter.isComplete = true
                        self.presenter.tasks = [Task(title: title, isCompleted: true), Task(title: "Second")]
                        
                        // when
                        self.presenter.fetchTasks()
                        cell = self.sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TaskCellView
                        
                        // then
                        expect(cell.titleLabel.text).to(equal(title))
                        expect(cell.isCompletedImageView.image).to(equal(#imageLiteral(resourceName: "Icons/Checked Circle")))
                    }
                }
            }

            describe("deleting a task") {
                context("when deleting a task") {
                    it("should show activity indicator when deleting") {
                        fail()
                    }
                    it("should show activity indicator when completed") {
                        fail()
                    }
                }

                context("when a task is deleted") {
                    it("should have 1 less task loaded") {
                        fail()
                    }
                    it("should show an error alert message") {
                        fail()
                    }
                }
            }
        }
    }
    
}
