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
    var originalTask:Task
    
    var task: Task
    
    @State
    private var modal = false
    
    @State
    var navigateToCurrentTaskView: Bool = false
    
    @State
    var navigateToEditTaskView: Bool = false
    
    @EnvironmentObject
    var week: Week
    
    var body: some View {
        
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
                        .fill(Color(hex: 0xF8F6ED))
                )
            }
//                // bloco checklist
//                List {
//                    Text("Checklist")
//                        .font(.caption)
//                        .fontWeight(.light)
//
//                    ForEach(Array(task.checklist.keys), id: \.self) { item in
//                        Text(item)
//
//                    }
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//
            ScrollView {
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
                            ForEach(Array(task.checklist.keys), id: \.self) { item in
                                Divider()
                                Text(item)
                                    .strikethrough(task.checklist[item] == true , color: .gray)
                                    .padding(.vertical, 10)
                                    .foregroundColor(task.checklist[item] == true ? .gray : .primary)
                            }
                        }
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 5)
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: 0xF8F6ED))
                    )
            }
            .padding(.top, 10)

            Spacer()
            
        // NavigationLink.init("",
                           // destination: CurrentTaskView(task: $originalTask),
                    //  isActive: $navigateToCurrentTaskView)
        
        // conferir se o horario bate com o da tarefa
        Button(action: {
            navigateToCurrentTaskView = true
            modal.toggle()
        }) {
          Text("Começar Tarefa")
        }
        .buttonStyle(GreenButtonStyle())
        //.sheet(isPresented: $modal, content: {
                    //CurrentTaskView(task: $originalTask)})

            
//        NavigationLink(destination: IniciarTaskView()) {
//            Text("Começar Tarefa")
//                .padding(.horizontal, 100)
//                .padding(.vertical, 15)
//                .background(Color("AccentColor"))
//                .foregroundStyle(.white)
//                .cornerRadius(8)
//        }
//        .frame(maxWidth: .infinity, alignment: .center)
            
        }
        .padding(.top, 15)
        .background(Color("BackgroundScreenColor"))
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
        .environmentObject(week)  // add e arrumar!!
        .sheet(isPresented: $modal, content: {
                            CurrentTaskView(task: $originalTask)
        })
        
        NavigationLink.init("",
                            destination: EditTaskView(task: $originalTask,
                                                      taskData: task),
                            isActive: $navigateToEditTaskView)

    }
}

//struct TaskInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskInfoView(task: Task.exampleTask)
//    }
//}
