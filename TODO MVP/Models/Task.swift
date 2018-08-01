//
//  Task.swift
//  TODO MVP
//
//  Created by Sylvan Ash on 30/07/2018.
//  Copyright © 2018 Sylvan Ash. All rights reserved.
//

struct Task {
    let title: String
    let isCompleted: Bool
}

extension Task {
    init(title: String) {
        self.title = title
        self.isCompleted = false
    }
}
