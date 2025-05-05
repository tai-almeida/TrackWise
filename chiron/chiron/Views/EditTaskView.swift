//
//  EditTaskView.swift
//  chiron
//
//  Created by Laris on 25/04/25.
//

import SwiftUI

struct EditTaskView: View {
    
    @Binding
    var task:Task
    
    var index:Int = 0
    
    @State
    var editableTask:Task

    init(task: Binding<Task>, taskData: Task){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        //_task = State(initialValue: task)
        self._task = task
        self._editableTask = State(initialValue: taskData)
        //self.editableTask.title = week.tasks[index].title
    }
        
    @State
    var completeAndReturn: Bool = false

    var body: some View {
            
        ZStack {
            // background
            Color("BackgroundScreenColor").ignoresSafeArea()
            
            Form {
                Section {
                    TextField("Titulo", text: $editableTask.title)
                    TextField("Localização", text: $editableTask.location)
                }
                .listRowBackground(Color(hex: 0xF8F6ED))

    
                Section {
                    DatePicker(
                        selection: $editableTask.date,
                        displayedComponents: .date, label: {
                        Text("Data")})
                    DatePicker(
                        selection: $editableTask.startTime,
                        displayedComponents: .hourAndMinute, label: {
                        Text("Inicio")})
                    DatePicker(
                        selection: $editableTask.endTime,
                        displayedComponents: .hourAndMinute, label: {
                        Text("Fim")})
                    }
                .listRowBackground(Color(hex: 0xF8F6ED))

        
                Section {
                        
                    HStack {
                        Text("Categoria")
                        Spacer()
                                                        
                        Menu {
                            Button(editableTask.category.rawValue.capitalized, action: {})
                            
                            ForEach(Category.allCases.filter { $0 != editableTask.category }, id: \.self) { category in
                                Button(category.rawValue.capitalized) {
                                    editableTask.category = category
                                }
                            }
                        } label: {
                            Text(editableTask.category.rawValue.capitalized)
                            Image(systemName: "chevron.up.chevron.down")
                            }
                            .modifier(ColorfulShapeStyle(backgroundColor: editableTask.category.color))
                        }
                    
                        HStack {
                            Text("Dificuldade")
                            Spacer()
                            
                            Menu {
                                Button(editableTask.difficulty.rawValue.capitalized, action: {})

                                ForEach(Difficulty.allCases.filter { $0 != editableTask.difficulty }, id: \.self) { difficulty in
                                    Button(difficulty.rawValue) {
                                        editableTask.difficulty = difficulty
                                    }
                                }
                            } label: {
                                Text(editableTask.difficulty.rawValue.capitalized)
                                Image(systemName: "chevron.up.chevron.down")
                            }
                            .modifier(ColorfulShapeStyle(backgroundColor: editableTask.difficulty.color))
                        }
                }
                .listRowBackground(Color(hex: 0xF8F6ED))
                
                Section(header: Text("Checklist")) {
                    List {
                        ForEach(Array(editableTask.checklist.keys), id: \.self) { item in
                            
                            //TextField("Item", text: $item)
                        }
                    }
                }
                .listRowBackground(Color(hex: 0xF8F6ED))

            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    completeAndReturn = true
                    task = editableTask
//                    task[
//                    editInfos(task: editableTask, title: "aa")]
                }) {
                    Text("Ok")
                        .foregroundColor(Color("AccentColor"))
                }
            }
        }
        
        NavigationLink.init("",
                            destination: TaskInfoView(originalTask: $task,
                                                      task: editableTask),
                            isActive: $completeAndReturn)
        }
    }

func editInfos(task: Task, title: String) -> Task {
    return task
}


//struct EditTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditTaskView(task: Task.exampleTask)
//    }
//}
