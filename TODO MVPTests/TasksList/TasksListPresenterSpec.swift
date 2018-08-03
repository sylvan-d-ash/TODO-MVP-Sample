//
//  TaksListPresenterSpec.swift
//  TODO MVPTests
//
//  Created by Sylvan Ash on 01/08/2018.
//  Copyright © 2018 Sylvan Ash. All rights reserved.
//

import Quick
import Nimble
@testable import TODO_MVP

class TasksListPresenterSpec: QuickSpec {
    
    class FakeTasksService: TaskService {
        private let tasks: [Task]
        private let error: Error?
        
        init(_ tasks: [Task], error: Error? = nil) {
            self.tasks = tasks
            self.error = error
        }
        
        override func getTasks(completion: @escaping ([Task], Error?) -> Void) {
            completion(tasks, error)
        }
    }
    
    class TasksListViewMock: TasksListDelegate {
        var tasks: [Task] = []
        var wasEmptyTasksReturned = false
        var wasErrorReturned = false
        var wasProgressShown = false
        var wasProgressHidden = false
        
        func showProgress() {
            wasProgressShown = true
        }
        func hideProgress() {
            wasProgressHidden = true
        }
        func setTasks(_ tasks: [Task]) {
            self.tasks = tasks
        }
        func setEmptyTasks() {
            wasEmptyTasksReturned = true
        }
        func showError(error: Error) {
            wasErrorReturned = true
        }
    }
    
    
    override func spec() {
        var sut: TasksListPresenter!
        
        describe("TasksListPresenterSpec") {
            context("fetch tasks") {
                it("should return 2 items") {
                    // given
                    let tasksViewMock = TasksListViewMock()
                    let tasksServiceFake = FakeTasksService([Task(title: "First"), Task(title: "Second")])
                    sut = TasksListPresenter(view: tasksViewMock, service: tasksServiceFake)
                    
                    // when
                    sut.fetchTasks()
                    
                    // then
                    expect(tasksViewMock.tasks.count).to(equal(2))
                    expect(tasksViewMock.wasProgressShown).to(equal(true))
                    expect(tasksViewMock.wasProgressHidden).to(equal(true))
                }
                
                it("should return an error") {
                    // given
                    let tasksViewMock = TasksListViewMock()
                    let taskServiceFake = FakeTasksService([], error: NetworkError.IncorrectDataReturned)
                    sut = TasksListPresenter(view: tasksViewMock, service: taskServiceFake)
                    
                    // when
                    sut.fetchTasks()
                    
                    // then
                    expect(tasksViewMock.wasErrorReturned).to(equal(true))
                    expect(tasksViewMock.wasProgressShown).to(equal(true))
                    expect(tasksViewMock.wasProgressHidden).to(equal(true))
                }
            }
            
            context("add task") {
                it("should return added task") {
                    fail()
                }
                
                it("should return an error") {
                    fail()
                }
            }
            
            context("update task") {
                it("should return edited task") {
                    fail()
                }
                
                it("should return an error") {
                    fail()
                }
            }
            
            context("search for a task") {
                it("should return 3 tasks") { // 0 or more tasks
                    fail()
                }
                
                it("should return an error") {
                    fail()
                }
            }
            
            context("delete task") {
                it("should removed deleted task") {
                    fail()
                }
                
                it("should return an error") {
                    fail()
                }
            }
        }
    }
    
}
