//
//  CurrentTaskView.swift
//  chiron
//
//  Created by Aluno 02 on 22/04/25.
//

import SwiftUI

struct CurrentTaskView: View {
    
    @Binding var task: Task
    
    @EnvironmentObject var week: Week
    
    @State private var editableTask: Task
    
    init(task: Binding<Task>) {
        // inicializacao customizada para iniciar editableTask
        self._task = task
        self._editableTask = State(initialValue: task.wrappedValue)
    }
    

    @Environment(\.dismiss) var dismiss // necessario para modal

    @State private var alertFim = false
    @State private var otimizarRotina = false
    @State private var finalizarTarefa = false
    @State private var proxima: Task? = nil
    
    @State private var tempoRestante: TimeInterval = 0
    @State private var tempoExtra: TimeInterval = 0
    
    
    
    func iniciarTimer() {
        // inicia ao abrir a tela
        let startTime = Date()
        tempoRestante = task.endTime.timeIntervalSince(startTime)

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            let restante = task.endTime.timeIntervalSince(Date())
            if restante <= 0 {
                timer.invalidate()
                proxima = proximaTarefa()
                alertFim = true
            } else {
                tempoRestante = restante
            }
        }
    }
    
    func novoTimer() {
        // inicia se tempo restante acabar
        let startTime = Date()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            tempoExtra = Date().timeIntervalSince(startTime)
        }
    }
    
    
    func proximaTarefa() -> Task? {
        // encontra qual a proxima tarefa em week
        let futuras = week.tasks.filter { $0.startTime > task.endTime }
        return futuras.sorted { $0.startTime < $1.startTime }.first
    }
    
    var body: some View {
        
        NavigationView {
            VStack (alignment: .leading) {
                
                VStack (alignment: .leading) {
                    // inicio estatico
                    Text(task.title)
                        .font(.title.bold())
                        .padding(.bottom, 10)
                    
                    Text(task.location)
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text(task.formattedRangeTime)
                        .padding(.bottom, 5)
                    
                    Text("Tempo restante: \(Int(tempoRestante / 60)) min")
                        .font(.subheadline)
                        .padding(.bottom, 10)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                Form {
                    // checklist
                    Section(header: Text("Checklist")) {
                        ForEach($editableTask.checklist) { $item in
                            HStack {
                                Text(item.title)
                                    .strikethrough(item.isDone)
                                    .foregroundColor(item.isDone ? .gray : .primary)
                                Spacer()
                                Button {
                                    item.isDone.toggle()
                                } label:{
                                    Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(item.isDone ? .green : .gray)
                                }
                            }
                            .listRowBackground(Color(hex:0xF8F6ED))
                        }
                    }
                }
                .frame(alignment: .topLeading)
                
                Spacer()
                
                VStack {
                    // botao finalizar tarefa
                    Button {
                        if (tempoRestante <= 0) {
                            otimizarRotina = true
                            task = editableTask
                        } else {
                            finalizarTarefa = true
                        }
                    } label: {
                        Text("Finalizar Tarefa")
                            .padding(.horizontal, 100)
                            .padding(.vertical, 15)
                            .background(Color(hex: 0x91A394))
                            .foregroundStyle(.white)
                            .cornerRadius(8)
                    }
                    .alert("Otimizar Rotina?", isPresented: $otimizarRotina, actions: {
                        // alerta para otimizar rotina (add tempo extra ao tempo medio)
                        Button("Sim", role: .cancel) {
                            task.averageTime += Int(tempoExtra)
                            dismiss()
                        }
                        Button("NÃ£o") { dismiss() }
                    }, message: {
                        Text("Passaram-se \(tempoExtra) do tempo programado\nDeseja atualizar a tarefa?")
                    })
                        .frame(maxWidth: .infinity, alignment: .center)
                    .alert("Finalizar Tarefa?", isPresented: $finalizarTarefa, actions: {
                        // alerta para finalizar tarefa mesmo
                        Button("Sim", role: .cancel) {
                            task = editableTask
                            dismiss()
                        }
                        Button("NÃ£o") { }
                    })
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .background(Color(hex: 0xEFE8D8))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    // botao de cancelar
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancelar")
                            .foregroundColor(Color(hex: 0x91A394))
                    }
                }
                ToolbarItem(placement: .principal) {
                    // barrinha no meio da toolbar
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.secondary)
                            .frame(width: 80, height: 5)
                            .padding(.top, 4)
                    }
            }
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
                iniciarTimer()
            }
            .alert("EstÃ¡ na hora de finalizar!", isPresented: $alertFim, actions: {
                // alerta para finalizar quando o tempoRestante acabar
                if proxima != nil {
                    Button("Continuar") {
                        tempoRestante = 0
                        novoTimer()
                    }
                    Button("PrÃ³xima", role: .cancel) {
                        dismiss()
                        //procurar como colocar para abrir a proxima tarefa
                    }
                } else {
                    Button("Finalizar") { dismiss() }
                    Button("Continuar") {
                        tempoRestante = 0
                        novoTimer()
                    }
                }
            }, message: {
                if let p = proxima {
                    Text("Continuar essa tarefa?\nA prÃ³xima tarefa Ã©\n\(p.title) Ã s \(p.formattedTime)")
                } else {
                    Text("NÃ£o hÃ¡ prÃ³xima tarefa")
                }
            })
            
        }
    }
}
