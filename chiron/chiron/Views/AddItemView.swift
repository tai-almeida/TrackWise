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
    
    
    // Instancias que representam o estado de variaveis que mudar com o input
    @State var SelectedPicker = 1
    
    @State var TaskName = ""
    @State var TaskLocation = ""
    @State var EventName = ""
    @State var EventLocation = ""
    @State var EventDate = ""
    @State var StartDate = Date()
    @State var EndDate = Date()
   
    
    var body: some View {
        
        VStack {
            Picker(selection: $SelectedPicker, label: Text("Picker"), content: {
            Text("Tarefa").tag(1)
            Text("Evento").tag(2)
            
                
            })
                .pickerStyle(SegmentedPickerStyle())
                .background(Color(hex: 0xF8F6ED)) // Your custom unselected background
                    
        
            if SelectedPicker == 1 {
                
                // Tudo que representa a secao tarefa
                
                ZStack {
                    
                    Color("BackgroundScreenColor")
                    
                    .ignoresSafeArea()
                    
                    VStack(alignment: .leading){
                        
                        Form {
                            Section {
                        TextField("Nome da Tarefa", text: $TaskName)
                        TextField("Localizacao", text: $TaskName)
                            }
                            .listRowBackground(Color(hex: 0xF8F6ED))
                        }

                        
                        Form {
                            Section{
                            DatePicker(selection: $StartDate, in: ...Date(), label: {
                                Text("Inicio")})
                            
                            DatePicker(selection: $EndDate, in: ...Date(), label: {
                                Text("Fim")})
                            }
                            .listRowBackground(Color(hex: 0xF8F6ED))
                        }
                        
                        Section {
                            
                        HStack {
                            
                            Text("Categoria")
                            
                         Spacer()
                            
                            Menu {
                                        Button("Adicionar", action: TagAdicionar)
                                        Button("Lazer", action: TagLazer)
                                        Button("Estudos", action: TagEstudo)
                                        Button("Domestico", action: TagDomestico)
                                        
                                    } label: {
                                        Image(systemName: "chevron.up.chevron.down")
                                            
                                    }
                        }
                        HStack {
                            
                            Text("Dificuldade")
                            
                            Spacer()
                            
                            Menu {
                           
                                        Button("Fácil", action: CatFacil)
                                        Button("Médio", action: CatMedio)
                                        Button("Difícil", action: CatDificil)
                            } label: {
                                Image(systemName: "chevron.up.chevron.down")
                                  
                            }
                        
                        
                                
                        
                            
                            }
                        }   .padding([.vertical], 0)
                            .padding([.horizontal],30)
                        
                        Form {
                            Section(header: Text("Checklist")){
                            Text("Subtarefa 1")
                            Text("Subtarefa 2")
                            Text("Subtarefa 3")
                            }
                            .listRowBackground(Color(hex: 0xF8F6ED))
                        }
                        
                        
                }
            }
            }
            if SelectedPicker == 2 {
                // Tudo que reperesenta eventos
                ZStack {
                    
                    Color.green
                    
                    .ignoresSafeArea()
                    
                VStack(alignment: .leading){
                    Form {
                        Section {
                    TextField("Nome do evento", text: $EventName)
                    TextField("Data", text: $EventDate)
                    TextField("Localizacao", text: $EventLocation)
                        }
                        .listRowBackground(Color(hex:0xF8F6ED))
                    }
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
        AddItemView()
    }
}
