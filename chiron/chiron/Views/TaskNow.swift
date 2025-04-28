//
//  TaskNow.swift
//  chiron
//
//  Created by Aluno 02 on 22/04/25.
//

import SwiftUI

struct TaskNow: View {
    
    @Binding
    var task: Task
    
    let startTime = Date()
    
    @Environment(\.dismiss) var dismiss
    //@State private var checklistState: [String: Bool] = [:]
    @State private var alertFim = false
    @State private var otimizarRotina = false
    
    
    func iniciarTimer() {
       // fazer se der tempo
    }
    
    func pararTimer() {
       // fazer se der tempo
    }
    
    func observarHora() {
        // codigo real
        if (startTime == task.endTime) {
            alertFim = true
        }
        //codigo de teste:
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            alertFim = true
            
        }
    }
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                
                VStack (alignment: .leading) {
                    Text(task.title)
                        .font(.title.bold())
                        .padding(.bottom, 10)
                    
                    Text(task.location)
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text(task.formattedRangeTime)
                        .padding(.bottom, 5)
                    
                    Text("Tempo restante: \(task.averageTime) min")
                        .font(.subheadline)
                        .padding(.bottom, 10)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                Form {
                    Section(header: Text("Checklist")) {
                        ForEach(Array(task.checklist), id: \.key) { item, isDone in
                            HStack {
                                Text(item)
                                    .strikethrough(isDone)
                                    .foregroundColor(isDone ? .gray : .primary)
                                Spacer()
                                Button {
                                    task.checklist[item]?.toggle()
                                } label:{
                                    Image(systemName: isDone ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(isDone ? .green : .gray)
                                }
                            }
                            .listRowBackground(Color(hex:0xF8F6ED))
                        }
                    }
                }
                .frame(alignment: .topLeading)
                
                Spacer()
                
                VStack {
                    Button {
                        otimizarRotina = true
                    } label: {
                        Text("Finalizar Tarefa")
                            .padding(.horizontal, 100)
                            .padding(.vertical, 15)
                            .background(Color(hex: 0x91A394))
                            .foregroundStyle(.white)
                            .cornerRadius(8)
                    }
                    .alert("Otimizar Rotina?", isPresented: $otimizarRotina, actions: {
                        Button("Sim", role: .cancel) { dismiss() }
                        Button("Não") { dismiss() }
                    }, message: {
                        Text("Passaram-se 20 minutos do tempo programado\nDeseja atualizar a tarefa?")
                    })
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .background(Color(hex: 0xEFE8D8))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancelar")
                            .foregroundColor(Color(hex: 0x91A394))
                    }
                }
                ToolbarItem(placement: .principal) {
                        // Indicador central do modal
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.secondary)
                            .frame(width: 80, height: 5)
                            .padding(.top, 4)
                    }
            }
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
                iniciarTimer()
                observarHora()
            }
            .alert("Está na hora de finalizar!", isPresented: $alertFim, actions: {
                Button("Continuar") { }
                Button("Próxima", role: .cancel) { dismiss() }
                //procurar como colocar para abrir a proxima tarefa
            }, message: {
                Text("Continuar essa tarefa?\nA próxima tarefa é\nLavar Roupa às 10:00")
            })
            
        }
    }
}




struct TaskNow_Previews: PreviewProvider {
    static var previews: some View {
        TaskNow(task: $task)
    }
}

