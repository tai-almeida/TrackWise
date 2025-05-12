//
//  ContentView.swift
//  AddTask
//
//  Created by Aluno 41 on 22/04/25.
//

import SwiftUI


struct AddItemView: View {
    @EnvironmentObject var schedule: Schedule
    @Environment(\.dismiss) var dismiss
        
        init() {
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("AccentColor")).toUIColor(color:Color("AccentColor"))
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        }
      
    // Instancias que representam o estado de variaveis que mudam com o input
    
    @State
    var task: Task = Task(title: "", location: "", date: Date(), startTime: Date(), endTime: Date(), category: .atv_fisica, difficulty: .facil, checklist: [], isCompleted: false, averageTime: 0)
    @State
    var event:Event = Event(id: 0, title: "", location: "", date: Date())
    
    @State var SelectedPicker = 1
    
    @State
    var isTask: Bool = false
    
    
    @State
    var completeAndReturn: Bool = false
    
    var body: some View {
        
        ZStack {
            
//            Color("BackgroundScreenColor")
//                .ignoresSafeArea()
            
            VStack {
                Picker(selection: $SelectedPicker, label: Text("Picker")) {
                    Text("Tarefa").tag(1)
                    Text("Evento").tag(2)
                    
                    
                }
                .pickerStyle(SegmentedPickerStyle())
                
                .background(.clear)
                .padding()
                
                Group {
                    if SelectedPicker == 1 {
                        Form1(task: $task)
                    } else if SelectedPicker == 2 {
                        Form {
                            Section {
                                TextField("Nome do Evento", text: $event.title)
                                TextField("Localização", text: $event.location)

                            }
                                                
                            Section {
                                DatePicker(selection: $event.date,
                                             in: Date()...,
                                             displayedComponents: [.date]) {
                                        Text("Data")
                                }
                            }

                    }
                }
                    Spacer()

                }
                .onAppear {
                    if SelectedPicker == 1 {
                        isTask = true
                    }
                    
                }
            }
            .background(Color(.secondarySystemBackground))

        }.navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Adicionar Tarefa")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        completeAndReturn = true
                        //var task = Task()
                        let components = Calendar.current.dateComponents([.minute], from: task.startTime, to: task.endTime)
                        task.averageTime = components.minute ?? 0
                        
                        if isTask {
                            schedule.tasks.append(task)
                        } else {
                            schedule.events.append(event)
                        }
                        dismiss()
                    }) {
                        Text("OK")
                            .foregroundColor(Color("AccentColor"))
                       
                    }
                    
                }
            }
    }
    
    
}



// Atribuir as funcoes a tarefas e init
func TagLazer() { }
func TagEstudo() { }
func TagDomestico() { }
func TagAdicionar() { }
func CatFacil() { }
func CatMedio() { }
func CatDificil() { }


struct Form1: View {
    
    @Binding
    var task:Task
    
    @State private var newSubitemTitle: String = ""
    
    var body: some View {
        
        Form {
            
            Section {
                TextField("Nome da Tarefa", text: $task.title)
                TextField("Localização", text: $task.location)
                
            }
            //.listRowBackground(Color(.secondarySystemBackground))
            
            Section{
                DatePicker(selection: $task.date, in: Date()..., displayedComponents: [.date], label: {
                    Text("Data")})
                
                DatePicker(selection: $task.startTime, in: Date()..., displayedComponents: [.hourAndMinute], label: {
                    Text("Início")})
                DatePicker(selection: $task.endTime, in: task.startTime..., displayedComponents: [.hourAndMinute], label: {
                    Text("Fim")})
            }
            //.listRowBackground(Color(.secondarySystemBackground))
            
            
            Section {
                HStack {
                   
                    Menu {
                        Section{
                            Button {
                            } label: {
                                Label("Adicionar", systemImage: "plus.circle")
                            }
                        }
                        Button("Lazer") {
                            task.category = .lazer
                        }
                        Button("Estudos") {
                            task.category = .estudos
                        }
                        Button("Faxina") {
                            task.category = .faxina
                        }
                        Button("Social") {
                            task.category = .social
                        }
                        Button("Atividade Física") {
                            task.category = .atv_fisica
                        }
                        
                    }
                    
                label: {
                    
                    Text("Categoria")
                        .foregroundStyle(.black)
                    Spacer()
                   
                    
                    Text("\(task.category.rawValue)")
                        .foregroundStyle(.secondary)
                        Image(systemName: "chevron.up.chevron.down")
                        .foregroundStyle(.secondary)
                        
                    }
                } .contentShape(Rectangle())
                
                HStack {
    
                    Menu {
                        Button("Difícil") {
                            task.difficulty = .dificil
                        }
                        Button("Médio") {
                            task.difficulty = .medio
                        }
                        Button("Fácil") {
                            task.difficulty = .facil
                        }
                        
                        
                    } label: {
                        Text("Dificuldade")
                            .foregroundStyle(.black)
                        Spacer()
                        
                        Text("\(task.difficulty.rawValue)")
                            .foregroundStyle(.secondary)
                        Image(systemName: "chevron.up.chevron.down")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            //.listRowBackground(Color(hex: 0xF8F6ED))
            
            Section(header: Text("Checklist")) {

                ForEach($task.checklist) { $item in
                    HStack {
                        TextField("Subtarefa", text: $item.title)
                        
                        Button(action: {
                            if let index = task.checklist.firstIndex(where: { $0.id == item.id }) {
                                task.checklist.remove(at: index)
                                task.updateCompletionStatus()
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
            //.listRowBackground(Color(hex: 0xF8F6ED))
            
        }
    }
    
    func addNewSubitem() {
        let newItem: ChecklistItem = ChecklistItem(title: newSubitemTitle, isDone: false)
        task.checklist.append(newItem)
        newSubitemTitle = ""
    }
    
}
