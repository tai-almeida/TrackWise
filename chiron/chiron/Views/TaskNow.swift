//
//  TaskNow.swift
//  chiron
//
//  Created by Aluno 02 on 22/04/25.
//

import SwiftUI

var checklist: [String] =
    ["Revisar capítulo 2", "Fazer Exercícios", "Corrigir exercícios"]
var tarefa = "Estudar Cálculo"
var local = "Biblioteca Central"
var horario_ini = DateComponents(hour: 8, minute: 0)
var horario_fim = DateComponents(hour: 9, minute: 0)
var tempo_restante = 30

func terminarTarefa() { }


struct TaskNow: View {
    
    @State private var tarefaFeita = false
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                
                VStack (alignment: .leading) {
                    Text(tarefa)
                        .font(.title.bold())
                        .padding(.bottom, 10)
                    
                    Text(local)
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text("8:00 - 9:00")
                        .padding(.bottom, 5)
                    
                    Text("Tempo restante: \(tempo_restante) min")
                        .font(.subheadline)
                        .padding(.bottom, 10)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                Form {
                    Section(header: Text("Checklist")) {
                        ForEach(checklist, id: \.self) { item in
                            HStack {
                                Text(item)
                                    .strikethrough(tarefaFeita)
                                    .foregroundColor(tarefaFeita ? .gray : .primary)
                                Spacer()
                                Button {
                                    tarefaFeita.toggle()
                                } label:{
                                    Image(systemName: tarefaFeita ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(tarefaFeita ? .green : .gray)
                                }
                            }
                            .listRowBackground(Color(hex:0xF8F6ED))
                        }
                    }
                }
                .frame(alignment: .topLeading)
                
                Spacer()
                
                VStack {
                    NavigationLink(destination: IniciarTaskView()) {
                                Text("Finalizar Tarefa")
                                    .padding(.horizontal, 100)
                                    .padding(.vertical, 15)
                                    .background(Color(hex: 0x91A394))
                                    .foregroundStyle(.white)
                                    .cornerRadius(8)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .background(Color(hex: 0xEFE8D8))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Tarefa de Agora")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {}) {
                        Text("Voltar")
                            .foregroundColor(Color(hex: 0x91A394))
                    }
                }
            }
        }
    }
}




struct TaskNow_Previews: PreviewProvider {
    static var previews: some View {
            TaskNow()
    }
}
