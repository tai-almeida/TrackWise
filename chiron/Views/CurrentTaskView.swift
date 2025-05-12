//
//  CurrentTaskView.swift
//  chiron
//
//  Created by Aluno 02 on 22/04/25.
import SwiftUI
struct CurrentTaskView: View {
    


    @Binding var task: Task
    
    @EnvironmentObject var schedule: Schedule
    
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
    @State private var continuar = false
    @State private var proxima: Task? = nil
    
    @State private var tempoRestante: TimeInterval = 0
    @State private var tempoExtra: TimeInterval = 0
    
    
    
    func iniciarTimer() {
        // inicia ao abrir a tela
        let startTime = Date()
        tempoRestante = task.endTime.timeIntervalSince(startTime)
        tempoRestante = (tempoRestante>=0 ? tempoRestante : 0)
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
        let futuras = schedule.tasks.filter { $0.startTime > task.endTime }
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
                    
                    Text("Tempo \(continuar ? String("extra: \(Int(tempoExtra)/60)") : String("restante: \(Int(tempoRestante)/60)")) min")
                        .font(.subheadline)
                        .padding(.bottom, 10)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                if !task.checklist.isEmpty {
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
                                        editableTask.updateCompletionStatus()

                                    } label:{
                                        Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(item.isDone ? .green : .gray)
                                    }
                                }
                                //.listRowBackground(Color(.secondarySystemBackground))
                            }
                        }
                    }
                    .frame(alignment: .topLeading)
                }
                
                Spacer()
                
                VStack {
                    // botao finalizar tarefa
                    Button {
                        if (tempoRestante <= 0 && continuar) {
                            otimizarRotina = true
                            task = editableTask
                        } else {
                            finalizarTarefa = true
                        }
                    } label: {
                        Text("Finalizar Tarefa")
                    }
                    .buttonStyle(GreenButtonStyle())
                    .alert("Otimizar Rotina?", isPresented: $otimizarRotina, actions: {
                        // alerta para otimizar rotina (add tempo extra ou diminui tempo restante do tempo medio)
                        Button("Sim", role: .cancel) {
                            if tempoRestante <= 0 {
                                task.averageTime = ((2*task.averageTime) + (Int(tempoExtra)/60))/2
                            } else {
                                task.averageTime = ((2*task.averageTime) - (Int(tempoRestante)/60))/2
                            }
                            dismiss()
                        }
                        Button("Não") { dismiss() }
                    }, message: {
                        if tempoRestante <= 0 {
                            Text("Passaram-se \(Int(tempoExtra)/60) min do tempo programado\nAtualizar o tempo médio da tarefa?")
                        } else {
                            Text("Você terminou com \(Int(tempoRestante)/60) min de sobra!\nAtualizar o tempo médio da tarefa?")
                        }
                    })
                        .frame(maxWidth: .infinity, alignment: .center)
                    .alert("Finalizar Tarefa?", isPresented: $finalizarTarefa, actions: {
                        // alerta para finalizar tarefa mesmo
                        Button("Sim", role: .cancel) {
                            task = editableTask
                            otimizarRotina = true
                        }
                        Button("Não") { }
                    })
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .background(Color(.secondarySystemBackground))
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
            .alert("Está na hora de finalizar!", isPresented: $alertFim, actions: {
                // alerta para finalizar quando o tempoRestante acabar
                if proxima != nil {
                    Button("Continuar") {
                        continuar = true
                        novoTimer()
                    }
                    Button("Próxima", role: .cancel) {
                        dismiss()
                        //procurar como colocar para abrir a proxima tarefa
                    }
                } else {
                    Button("Finalizar") { dismiss() }
                    Button("Continuar") {
                        continuar = true
                        novoTimer()
                    }
                }
            }, message: {
                if let p = proxima {
                    Text("Continuar essa tarefa?\nA próxima tarefa é\n\(p.title) às \(p.formattedTime)")
                } else {
                    Text("Não há próxima tarefa")
                }
            })
            
        }
    }
}
