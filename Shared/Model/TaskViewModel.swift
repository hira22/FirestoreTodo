//
//  TaskCellViewModel.swift
//  FirestoreTodo
//
//  Created by hiraoka on 2020/07/22.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import Foundation

class TaskCellViewModel: ObservableObject {
    @Published var tasks: [Task]

    init() {
        tasks = testDataTasks
    }
}
