//
//  TaskRepository.swift
//  FirestoreTodo
//
//  Created by hiraoka on 2020/08/08.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

class TaskRepository: ObservableObject {
    @Published var tasks: [Task] = []

    private var tasksCollectionRef: CollectionReference?

    private var userRepository: UserRepository = .init()

    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        userRepository.$currentUser
            .filter { $0 != nil }
            .sink { (user: User?) in
                self.tasksCollectionRef = db.collection("users").document(user!.id!).collection(
                    "tasks")
                self.loadData()
            }
            .store(in: &cancellableSet)
    }

    private func loadData() {
        tasksCollectionRef?.order(by: "createdAt")
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
        _ = try! tasksCollectionRef?.addDocument(from: task)
    }

    func updateTask(_ task: Task) {
        guard let id = task.id else { return }
        try! tasksCollectionRef?.document(id).setData(from: task)
    }

    func removeTask(_ task: Task) {
        guard let id = task.id else { return }
        tasksCollectionRef?.document(id).delete()
    }
}
