//
//  TaskCellViewModel.swift
//  FirestoreTodo
//
//  Created by hiraoka on 2020/07/22.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import Foundation
import Combine

class TaskCellViewModel: ObservableObject, Identifiable {
    @Published var taskRepository: TaskRepository = .init()
    @Published var task: Task
    
    var id: String = ""
    @Published var completionStateIconName: String = ""
    
    private var cancellableSet = Set<AnyCancellable>()
    
    init(task: Task) {
        self.task = task
        
        $task
            .map { (task: Task) in
            task.completed ? "checkmark.circle.fill" : "circle"
        }
        .assign(to: \.completionStateIconName, on: self)
        .store(in: &cancellableSet)
        
        $task
            .compactMap {(task: Task) in
            task.id
        }
        .assign(to: \.id, on: self)
        .store(in: &cancellableSet)
        
        $task
            .dropFirst()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink { (task: Task) in
                self.taskRepository.updateTask(task)
        }
        .store(in: &cancellableSet)
    }
    
    func removeTask() {
        self.taskRepository.removeTask(task)
    }
}
