//
//  TarefaInfoView.swift
//  chiron
//
//  Created by Laris on 15/04/25.
//

import Foundation
import SwiftUI

struct TaskInfoView: View {
    
    @Binding
    var originalTask: Task
    
    var task: Task
    
    @State
    var navigateToCurrentTaskView: Bool = false
    
    @State
    var navigateToEditTaskView: Bool = false
    
   // @Binding var isActive: Bool
    
    @State
    var modalCurrentTaskView: Bool = false
    
    @StateObject var schedule = Schedule()
    
    var body: some View {
        
        VStack { ScrollView {

        VStack (alignment: .leading){
            
            VStack(alignment: .leading) {
                
                // bloco infos principais
                VStack (alignment: .leading){
                    Text(task.title)
                        .font(.title.bold())
                        .padding(.bottom, 10)
                    
                    Text(task.location)
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text(task.formattedRangeTime)
                        .padding(.bottom, 5)
                    
                    Text("Tempo médio: \(task.averageTime) min")
                        .font(.subheadline)
                        .padding(.bottom, 5)
                }
                
                // bloco infos secundárias
                VStack {
                    HStack {
                        Text("Data")
                        Spacer()
                        Text(task.formattedData)
                            .foregroundStyle(.secondary)
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Categoria")
                        Spacer()
                        Text(task.category.rawValue.capitalized)
                            .modifier(ColorfulShapeStyle(backgroundColor: task.category.color))
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Dificuldade")
                        Spacer()
                        Text(task.difficulty.rawValue)
                            .modifier(ColorfulShapeStyle(backgroundColor: task.difficulty.color))
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                )
            }

                // bloco checklist
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Checklist")
                            .font(.caption)
                            .fontWeight(.light)
                            .padding(.bottom, 4)
                        
                        if (task.checklist.count == 0) {
                            Divider()
                            Text("Não há subtarefas!")
                                .padding(.vertical, 10)
                                .foregroundColor(.secondary)
                        } else {
                            ForEach(task.checklist, id: \.id) { item in
                                Divider()
                                Text(item.title)
                                    .strikethrough(item.isDone == true , color: .gray)
                                    .padding(.vertical, 10)
                                    .foregroundColor(item.isDone == true ? .gray : .primary)
                            }
                        }
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 5)
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                    )
            }
            .padding(.top, 10)

            Spacer()
        }
        
        // conferir se o horario bate com o da tarefa
        if let adjustedStart = Calendar.current.date(byAdding: .minute, value: -5, to: task.startTime),
           Date() >= adjustedStart && Date() <= task.endTime {

            Button(action: {
                navigateToCurrentTaskView = true
                modalCurrentTaskView.toggle()
            }) {
                Text("Começar Tarefa")
            }
            .buttonStyle(GreenButtonStyle())
        }

        }

        .padding()
        .background(Color(.secondarySystemBackground))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Detalhes da Tarefa")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    navigateToEditTaskView = true
                }) {
                    Text("Editar")
                        .foregroundColor(Color("AccentColor"))
                }
            }
        }
        .sheet(isPresented: $modalCurrentTaskView, content: {
            CurrentTaskView(task: $originalTask)
        })
        
        NavigationLink.init("",
                            destination: EditTaskView(task: $originalTask,
                                                      taskData: task).environmentObject(schedule),
                                                     // isActive: $navigateToEditTaskView)
                                                    
                            isActive: $navigateToEditTaskView)

    }
}

//struct TaskInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskInfoView(task: Task.exampleTask)
//    }
//}
