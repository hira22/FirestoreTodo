//
//  TaskListView.swift
//  FirestoreTodo
//
//  Created by hiraoka on 2020/07/22.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    
    @State var presentAddNewItem: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(taskListVM.taskCellViewModels) { taskCellVM in
                        TaskCell(taskCellVM: taskCellVM)
                    }
                    .onDelete(perform: remove)
                    
                    if presentAddNewItem {
                        TaskCell(taskCellVM: TaskCellViewModel(task: Task(title: "", completed: false))) { (task: Task) in
                            self.taskListVM.addTask(task: task)
                            self.presentAddNewItem.toggle()
                        }
                    }
                }
                AddNewTaskButton(presentAddNewItem: $presentAddNewItem)
            }
            .navigationBarTitle("Tasks")
        }
    }
    
    func remove(offsets: IndexSet) {
        taskListVM.taskCellViewModels[offsets.first!].removeTask()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
// MARK: TaskCell
struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    
    var onCommit: (Task) -> Void = { _ in }
    
    var body: some View {
        HStack {
            Image(systemName: taskCellVM.completionStateIconName)
                .resizable()
                .frame(width: 20, height: 20, alignment: .center)
                .onTapGesture {
                    self.taskCellVM.task.completed.toggle()
            }
            TextField("Enter the task title", text: $taskCellVM.task.title, onCommit: {
                self.onCommit(self.taskCellVM.task)
            })
        }
    }
}

// MARK: AddNewTaskButton
struct AddNewTaskButton: View {
    @Binding var presentAddNewItem: Bool
    
    var body: some View {
        Button(action: { self.presentAddNewItem.toggle() }) {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                Text("Add New Task")
            }
        }
        .padding()
    }
}
