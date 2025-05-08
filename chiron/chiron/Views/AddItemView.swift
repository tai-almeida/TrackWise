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
            UISegmentedControl.appearance().selectedSegmentTintColor = .white //UIColor(Color("AccentColor")).toUIColor(color: Color("AccentColor"))
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor((Color("AccentColor"))).toUIColor(color: Color("AccentColor"))], for: .normal)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
            UISegmentedControl.appearance().backgroundColor = UIColor(Color("AccentColor")).toUIColor(color:Color("AccentColor"))

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
            
            Color("BackgroundScreenColor")
                .ignoresSafeArea()
            
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
                        
                        // Tudo que representa a secao tarefa
                        
                        Form1(task:$task)
                        
                    } else if SelectedPicker == 2 {
                        VStack(spacing: 0) {
                            VStack(spacing: 0) {
                                GroupBox {
                                    TextField("Nome do evento", text: $event.title)
                                        //.padding()
                                    Divider()
                                    TextField("Localizacao", text: $event.location)
                                        //.padding()
                                    Divider()
                                    DatePicker(selection: $event.date, in: Date()..., displayedComponents: [.date], label: {
                                        Text("Data")})
                                    
                                    
                                    
                                    
                                }
                            }
                                .cornerRadius(10)
                                //.background(Color("AccentColor"))
                                .padding()
                            
                            Spacer()
                        }
                    }
                }.onAppear {
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
                            .foregroundColor(.white)
                       
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
    
    
    var body: some View {
        
        Form {
            
            Section {
                TextField("Nome da Tarefa", text: $task.title)
                TextField("Localizacao", text: $task.location)
                
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
                        Button("Fácil") {
                            task.difficulty = .facil
                        }
                        Button("Médio") {
                            task.difficulty = .medio
                        }
                        Button("Difícil") {
                            task.difficulty = .dificil
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
            
            Section(header: Text("Checklist")){
                Text("Subtarefa 1")
                Text("Subtarefa 2")
                Text("Subtarefa 3")
            }
            //.listRowBackground(Color(hex: 0xF8F6ED))
            
        }
    }
    
}
