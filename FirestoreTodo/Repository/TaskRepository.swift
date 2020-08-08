//
//  TaskRepository.swift
//  FirestoreTodo
//
//  Created by hiraoka on 2020/08/08.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskRepository: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var tasks: [Task] = []
    
    init() {
        loadData()
    }
    
    private func loadData() {
        db.collection("tasks").order(by: "createdAt")
            .addSnapshotListener { (querySnapshot: QuerySnapshot?, _: Error?) in
                if let querySnapshot = querySnapshot {
                    self.tasks = querySnapshot.documents
                        .compactMap { (document: QueryDocumentSnapshot) -> Task? in
                            try! document.data(as: Task.self)
                        }
                }
            }
    }
    
    func addTask(_ task: Task) {
        _ = try! db.collection("tasks").addDocument(from: task)
    }
    
    func updateTask(_ task: Task) {
        guard let id = task.id else { return }
        try! db.collection("tasks").document(id).setData(from: task)
    }
    
    func removeTask(_ task: Task) {
        guard let id = task.id else { return }
        db.collection("tasks").document(id).delete()
    }
}
