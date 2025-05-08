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
    
   // @Binding var isActive: Bool
    
    @State private var newSubitemTitle: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var schedule: Schedule
    
    init(task: Binding<Task>, taskData: Task) {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear

        self._task = task
        self._editableTask = State(initialValue: taskData)
       // self._isActive = isActive
    }

    var body: some View {
        
        // background
        ZStack {
            Color(.secondarySystemBackground).ignoresSafeArea()
                            
            Form {
                
                Section {
                    TextField("Titulo", text: $editableTask.title)
                    TextField("Localização", text: $editableTask.location)
                }
                    //.listRowBackground(Color(.secondarySystemBackground))

    
                Section {
                    DatePicker(
                        selection: $editableTask.date,
                        in: Date()...,
                        displayedComponents: .date,
                        label: {
                            Text("Data")
                        })
                    DatePicker(
                        selection: $editableTask.startTime,
                        displayedComponents: .hourAndMinute,
                        label: {
                            Text("Inicio")
                        })
                    DatePicker(
                        selection: $editableTask.endTime,
                        in: editableTask.startTime...,
                        displayedComponents: .hourAndMinute,
                        label: {
                            Text("Fim")
                        })
                    }
                //.listRowBackground(Color(.secondarySystemBackground))

        
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
                //.listRowBackground(Color(.secondarySystemBackground))
                
                
                Section(header: Text("Checklist")) {

                    ForEach($editableTask.checklist) { $item in
                        HStack {
                            Button(action: {
                                item.isDone.toggle()
                                editableTask.updateCompletionStatus()
                            }) {
                                Image(systemName: item.isDone ? "checkmark.circle" : "circle")
                                    .foregroundColor(item.isDone ? .green : .gray)
                            }
                            .buttonStyle(.plain)

                            TextField("Subtarefa", text: $item.title)

                            Button(action: {
                                if let index = editableTask.checklist.firstIndex(where: { $0.id == item.id }) {
                                    editableTask.checklist.remove(at: index)
                                    editableTask.updateCompletionStatus()
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
                //.listRowBackground(Color(.secondarySystemBackground))
                
                
                Section {
                    Button(action: {
                        if let index = schedule.tasks.firstIndex(where: { $0.id == task.id }) {
                            schedule.tasks.remove(at: index)
                            dismiss()
                        } else {
                            print("Não achei!")
                        }
                    }) {
                        Text("Excluir Tarefa")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.red)
                    }
                }
                .listRowBackground(Color(.secondarySystemBackground))


            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .background(Color(.secondarySystemBackground))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        task = editableTask
                        dismiss()
                    }
                }
            }
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
