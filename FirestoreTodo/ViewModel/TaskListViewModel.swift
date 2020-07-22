//
//  TaskListViewModel.swift
//  FirestoreTodo
//
//  Created by hiraoka on 2020/07/22.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import Foundation
import Combine

class TaskListViewModel: ObservableObject {
    @Published var taskCellViewModels: [TaskCellViewModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.taskCellViewModels = testDataTasks.map { (task: Task) in
            TaskCellViewModel(task: task)
        }
    }
    
    func addTask(task: Task) {
        taskCellViewModels.append(TaskCellViewModel(task: task))
    }
}
