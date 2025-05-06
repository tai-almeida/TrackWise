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
    
    @State private var newSubitemTitle: String = ""
    
    @Environment(\.dismiss) var dismiss


    init(task: Binding<Task>, taskData: Task){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear

        self._task = task
        self._editableTask = State(initialValue: taskData)
    }

    var body: some View {
        
        // background
        ZStack {
            Color("BackgroundScreenColor").ignoresSafeArea()
                            
            Form {
                
                Section {
                    TextField("Titulo", text: $editableTask.title)
                    TextField("Localização", text: $editableTask.location)
                }
                    .listRowBackground(Color(.secondarySystemBackground))

    
                Section {
                    DatePicker("Data", selection: $editableTask.date, in: ...Date(), displayedComponents: .date)
                    DatePicker("Início", selection: $editableTask.startTime, in: ...Date(), displayedComponents: .hourAndMinute)
                    DatePicker("Fim", selection: $editableTask.endTime, in: ...Date(), displayedComponents: .hourAndMinute)
                }
                    .listRowBackground(Color(.secondarySystemBackground))

        
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
                                .modifier(ColorfulShapeStyle(backgroundColor:
                                                             editableTask.category.color))
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
                                    .modifier(ColorfulShapeStyle(backgroundColor:
                                                                 editableTask.difficulty.color))
                        }
                }
                .listRowBackground(Color(.secondarySystemBackground))
                
                
                Section(header: Text("Checklist")) {

                    ForEach($editableTask.checklist) { $item in
                        HStack {
                            Button(action: {
                                item.isDone.toggle()
                            }) {
                                Image(systemName: item.isDone ? "checkmark.circle" : "circle")
                                    .foregroundColor(item.isDone ? .green : .gray)
                            }
                            .buttonStyle(.plain)

                            TextField("Subtarefa", text: $item.title)

                            Button(action: {
                                if let index = editableTask.checklist.firstIndex(where: { $0.id == item.id }) {
                                    editableTask.checklist.remove(at: index)
                                }
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.secondary)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    
                    // implementar logica para criar um campo vazio que adiciona um chacklistitem no array checklist
                    // se adicionar um novo, aparece outro campo em branco
                    
                    HStack {
                        TextField("Nova subtarefa", text: $newSubitemTitle, onCommit: {
                            addNewSubitem()
                        })
                        .submitLabel(.done)
                    }
                    
                }
                .listRowBackground(Color(.secondarySystemBackground))
                
                
            }

        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    task = editableTask
                    dismiss()
                }) {
                    Text("Ok")
                        .foregroundColor(Color("AccentColor"))
                }
            }
        }
        
        
//        NavigationLink.init("",
//                            destination: TaskInfoView(originalTask: $task,
//                                                      task: editableTask),
//                            isActive: $completeAndReturn)
        }
    }
    
    func addNewSubitem() {
        let newItem: ChecklistItem = ChecklistItem(title: newSubitemTitle, isDone: false)
        editableTask.checklist.append(newItem)
        newSubitemTitle = ""
    }
    
}



//struct EditTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditTaskView(task: Task.exampleTask)
//    }
//}
