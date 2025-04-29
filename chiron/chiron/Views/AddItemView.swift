//
//  ContentView.swift
//  AddTask
//
//  Created by Aluno 41 on 22/04/25.
//

import SwiftUI


struct AddItemView: View {
    
    init(){
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
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    
    // Instancias que representam o estado de variaveis que mudam com o input
    @State var SelectedPicker = 1
    
    @State var TaskName = ""
    @State var TaskLocation = ""
    @State var EventName = ""
    @State var EventLocation = ""
    @State var EventDate = ""
    @State var StartDate = Date()
    @State var StartTime = Date()
    @State var EndTime = Date()
    @State var selectedCategoria = "Nenhuma"
    @State var selectedDificuldade = "Nenhuma"

    
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
                            
                            Form {
                                Section {
                            TextField("Nome da Tarefa", text: $TaskName)
                            TextField("Localizacao", text: $TaskLocation)
                                }
                                .listRowBackground(Color(hex: 0xF8F6ED))
                            

                            
                            
                                Section{
                                    DatePicker(selection: $StartDate, in: Date()..., displayedComponents: [.date], label: {
                                    Text("Data")})
                                
                                    DatePicker(selection: $StartTime, in: Date()..., displayedComponents: [.hourAndMinute], label: {
                                    Text("Início")})
                                    DatePicker(selection: $EndTime, in: Date()..., displayedComponents: [.hourAndMinute], label: {
                                    Text("Fim")})
                                }
                                .listRowBackground(Color(hex: 0xF8F6ED))
                            
                            
                            Section {
                                
                            HStack {
                                
                                Text("Categoria")
                                Spacer()
                               Text("\(selectedCategoria)")
                                    .foregroundStyle(.secondary)
                                
                           
                                
                                Menu {
                                  
                                    Section{
                                    Button {
                                            selectedCategoria = "Adicionar"
                                        } label: {
                                            Label("Adicionar", systemImage: "plus.circle")
                                        }
                                    }
                                    Button("Lazer") { selectedCategoria = "Lazer" } 
                                    Button("Estudos") { selectedCategoria = "Estudos" }
                                    Button("Domestico") { selectedCategoria = "Domestico" }
                                            
                                        } label: {
                                            Image(systemName: "chevron.up.chevron.down")
                                                
                                        }
                            }
                                
                            HStack {
                                
                                Text("Dificuldade")
                                
                                Spacer()
                               Text("\(selectedDificuldade)")
                                    .foregroundStyle(.secondary)
                                
                                
                                Menu {
                               
                                    Button("Fácil") { selectedDificuldade = "Fácil" }
                                    Button("Médio") { selectedDificuldade = "Médio" }
                                    Button("Difícil") { selectedDificuldade = "Difícil" }
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
                
                    else if SelectedPicker == 2 {
                        // Tudo que representa a secao evento
                        
                        
                        VStack(spacing: 0) {
                            VStack(spacing: 0) {
                                Group {
                                    TextField("Nome do evento", text: $EventName)
                                        .padding()
                                    Divider()

                                    TextField("Data", text: $EventDate)
                                        .padding()
                                    Divider()

                                    TextField("Localizacao", text: $EventLocation)
                                        .padding()
                                }
                            }
                            .background(Color(hex: 0xF8F6ED))
                            .cornerRadius(10)
                            .padding()
                            
                            Spacer()
                        }
                    }

                    
                }
        }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Adicionar Tarefa")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
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
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View  {
        NavigationView{
        AddItemView()
        }
    }
}
