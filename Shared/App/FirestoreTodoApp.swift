//
//  FirestoreTodoApp.swift
//  Shared
//
//  Created by hiraoka on 2020/09/21.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import SwiftUI

import Firebase

@main
struct FirestoreTodoApp: App {
    private lazy var userRepository: UserRepository = .init()
    init() {
        FirebaseApp.configure()
        userRepository.signInAnonymously()
    }
    
    var body: some Scene {
        WindowGroup {
            TaskListView()
        }
    }
}
