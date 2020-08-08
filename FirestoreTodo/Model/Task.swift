//
//  Task.swift
//  FirestoreTodo
//
//  Created by hiraoka on 2020/07/22.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift

struct Task: Codable, Identifiable {
    @DocumentID var id: String?
    
    var title: String
    var completed: Bool
    
    @ServerTimestamp var createdAt: Timestamp?
}

#if DEBUG
    let testDataTasks: [Task] = [
        Task(title: "Implement the UI", completed: true),
        Task(title: "Task", completed: true),
        Task(title: "AAAAAAAAA", completed: false),
        Task(title: "BBBBBBBBB", completed: false),
        Task(title: "CCCCCCCCC", completed: false),
        Task(title: "DDDDDDDDD", completed: false),
    ]
#endif
