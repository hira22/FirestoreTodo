//
//  TaskListViewModel.swift
//  FirestoreTodo
//
//  Created by hiraoka on 2020/07/22.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import Combine
import Foundation

class TaskListViewModel: ObservableObject {
    @Published private var taskRepository: TaskRepository

    @Published var taskCellViewModels: [TaskCellViewModel] = []

    private var cancellableSet: Set<AnyCancellable> = []

    init(repository: TaskRepository = .init()) {
        taskRepository = repository

        taskRepository.$tasks
            .map { (tasks: [Task]) in tasks.map(TaskCellViewModel.init) }
            .assign(to: \.taskCellViewModels, on: self)
            .store(in: &cancellableSet)
    }

    func addTask(task: Task) {
        taskRepository.addTask(task)
    }
}
