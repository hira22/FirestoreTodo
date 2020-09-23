//
//  FirestoreTodoApp.swift
//  Shared
//
//  Created by hiraoka on 2020/09/21.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import Firebase
import SwiftUI

@main
struct FirestoreTodoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            TaskListView()
        }
    }
}
