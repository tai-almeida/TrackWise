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
        self._task = task
        self._editableTask = State(initialValue: task.wrappedValue)
    }
    

    @Environment(\.dismiss) var dismiss

    @State private var alertFim = false
    @State private var otimizarRotina = false
    @State private var proxima: Task? = nil
    
    @State private var tempoRestante: TimeInterval = 0
    let startTime = Date()
    
    
    func iniciarTimer() {
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
        var extraTime = 0
        if !
       // inicia se tempo restante acabar
    }
    
//    func observarHora() {
//        // codigo real
//        if (startTime >= task.endTime) {
//            proxima = proximaTarefa()
//            alertFim = true
//        }
//        //codigo de teste:
//        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//            proxima = proximaTarefa()
//            alertFim = true
//
//        }
//    }
    
    func proximaTarefa() -> Task? {
        let futuras = week.tasks.filter { $0.startTime > task.endTime }
        return futuras.sorted { $0.startTime < $1.startTime }.first
    }
    
    var body: some View {
        
        var tempoRestante = task.endTime.timeIntervalSince(startTime)
        
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
                    
                    Text("Tempo restante: \(Int(tempoRestante / 60)) min")
                        .font(.subheadline)
                        .padding(.bottom, 10)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                Form {
                    Section(header: Text("Checklist")) {
                        ForEach(Array(editableTask.checklist), id: \.key) { item, isDone in
                            HStack {
                                Text(item)
                                    .strikethrough(isDone)
                                    .foregroundColor(isDone ? .gray : .primary)
                                Spacer()
                                Button {
                                    editableTask.checklist[item]?.toggle()
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
                        task = editableTask
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
                //observarHora()
            }
            .alert("Está na hora de finalizar!", isPresented: $alertFim, actions: {
                
                if proxima != nil {
                    Button("Continuar") {
                        tempoRestante = 0
                        novoTimer()
                    }
                    Button("Próxima", role: .cancel) {
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
                    Text("Continuar essa tarefa?\nA próxima tarefa é\n\(p.title) às \(p.formattedTime)")
                } else {
                Text("Não há próxima tarefa")
                }
            })
            
        }
    }
}



//struct CurrentTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrentTaskView(task: .constant(Task.exampleTask), week: <#T##Week#>)
//    }
//}

