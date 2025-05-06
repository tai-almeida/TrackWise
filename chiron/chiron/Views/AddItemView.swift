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
    //init(){
    // Muda cor do picker slecionado
    
    // UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.red)
    
    // Muda cor do texto do picker
    //            UISegmentedControl.appearance().setTitleTextAttributes(
    //                [NSAttributedString.Key.foregroundColor: UIColor.white],
    //                for: .selected
    //            )
    //        //
    //            UISegmentedControl.appearance().setTitleTextAttributes(
    //                [NSAttributedString.Key.foregroundColor: UIColor.black],
    //                for: .normal
    //            )
    // UITableView.appearance().backgroundColor = .clear
    // UITableViewCell.appearance().backgroundColor = .clear
    //}
    
    
    // Instancias que representam o estado de variaveis que mudam com o input
    
    @State
    var task: Task = Task(title: "", location: "", date: Date(), startTime: Date(), endTime: Date(), category: .atv_fisica, difficulty: .facil, checklist: [:], isCompleted: false, averageTime: 0)
    @State
    var event:Event = Event(id: 0, title: "", location: "", date: Date())
    
    @State var SelectedPicker = 1

    
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
                .background(Color(hex: 0xF8F6ED))
                .padding()
                
                
                if SelectedPicker == 1 {
                    
                    // Tudo que representa a secao tarefa
                    
                    Form1(task:$task)
                    
                }  else if SelectedPicker == 2 {
                    VStack(spacing: 0) {
                        VStack(spacing: 0) {
                            Group {
                                TextField("Nome do evento", text: $event.title)
                                    .padding()
                                Divider()
                                
                                DatePicker(selection: $event.date, in: Date()..., displayedComponents: [.date], label: {
                                    Text("Data")})
                                
                                Divider()
                                
                                TextField("Localizacao", text: $event.location)
                                    .padding()
                            }
                        }.background(Color(hex: 0xF8F6ED))
                            .cornerRadius(10)
                            .padding()
                        
                        Spacer()
                        
                        
                       
                    }

                    
                    
                }

            }

        }.navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Adicionar Tarefa")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        completeAndReturn = true
                        //var task = Task()
                        let components = Calendar.current.dateComponents([.minute], from: task.startTime, to: task.endTime)
                        task.averageTime = components.minute ?? 0

                        schedule.tasks.append(task)
                        schedule.events.append(event)
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
    
    var body: some View {
        
        Form {
            Section {
                TextField("Nome da Tarefa", text: $task.title)
                TextField("Localizacao", text: $task.location)
            }
            .listRowBackground(Color(hex: 0xF8F6ED))
            
            
            
            
            Section{
                DatePicker(selection: $task.date, in: Date()..., displayedComponents: [.date], label: {
                    Text("Data")})
                
                DatePicker(selection: $task.startTime, in: Date()..., displayedComponents: [.hourAndMinute], label: {
                    Text("Início")})
                DatePicker(selection: $task.endTime, in: Date()..., displayedComponents: [.hourAndMinute], label: {
                    Text("Fim")})
            }
            .listRowBackground(Color(hex: 0xF8F6ED))
            
            
            Section {
                
                HStack {
                    
                    Text("Categoria")
                    Spacer()
                    Text("\(task.category.rawValue)")
                                            .foregroundStyle(.secondary)
                    
                    
                    
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
                            //Text("Atividade Física")
                            
                        }
                        
                    } label: {
                        Image(systemName: "chevron.up.chevron.down")
                        
                    }
                }
                
                HStack {
                    
                    Text("Dificuldade")
                    
                    Spacer()
                    Text("\(task.difficulty.rawValue)")
                                            .foregroundStyle(.secondary)
                    
                    
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
                        Image(systemName: "chevron.up.chevron.down")
                        
                    }
                }
            }
            .listRowBackground(Color(hex: 0xF8F6ED))
            
            Section(header: Text("Checklist")){
                Text("Subtarefa 1")
                Text("Subtarefa 2")
                Text("Subtarefa 3")
            }
            .listRowBackground(Color(hex: 0xF8F6ED))
            
        }
    }
    
}
