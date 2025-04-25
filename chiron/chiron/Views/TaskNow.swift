//
//  TaskNow.swift
//  chiron
//
//  Created by Aluno 02 on 22/04/25.
//

import SwiftUI

func terminarTarefa() { }


struct TaskNow: View {
    
    var task: Task
    
    @Environment(\.dismiss) var dismiss
    @State private var checklistState: [String: Bool] = [:]
    
    init(task: Task) {
        UITableView.appearance().backgroundColor = .clear
        self.task = task
        _checklistState = State(initialValue: task.checklist)
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
                    
                    Text("Tempo restante: \(task.formattedTime) min")
                        .font(.subheadline)
                        .padding(.bottom, 10)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                Form {
                    Section(header: Text("Checklist")) {
                        ForEach(Array(checklistState), id: \.key) { item, isDone in
                            HStack {
                                Text(item)
                                    .strikethrough(isDone)
                                    .foregroundColor(isDone ? .gray : .primary)
                                Spacer()
                                Button {
                                    checklistState[item]?.toggle()
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
                        dismiss()
                    } label: {
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
        }
    }
}




struct TaskNow_Previews: PreviewProvider {
    static var previews: some View {
        TaskNow(task: Task.exampleTask)
    }
}

/*

import SwiftUI

struct FullScreenModalView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                VStack(spacing: 20) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height * 1.0)
                .background(Color.white)
                .cornerRadius(20)
            }

        }
    }
}

*/
/*

struct ContentView: View {
    @State private var isPresented = false

    var body: some View {
        Button("Show") {
            isPresented.toggle()
        }
        .sheet(isPresented: $isPresented) {
            FullScreenModalView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
