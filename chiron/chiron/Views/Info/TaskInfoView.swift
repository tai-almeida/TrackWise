//
//  TarefaInfoView.swift
//  chiron
//
//  Created by Laris on 15/04/25.
//

import Foundation
import SwiftUI

struct TaskInfoView: View {
    
    @State private var modal = false // !!!!! add !!!!!!!
    
    @Binding var task: Task
    
    var body: some View {
        
        VStack (alignment: .leading){
            
            ScrollView {
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
                    }
                    
                    // bloco infos secundárias
                    VStack {
                        HStack {
                            Text("Data")
                            Spacer()
                            Text(task.formattedData)
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Categoria")
                            Spacer()
                            Text(task.category.rawValue.capitalized)
                                .font(.callout)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(task.category.color)
                                .foregroundStyle(.white)
                                .clipShape(Capsule())
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Dificuldade")
                            Spacer()
                            Text(task.difficulty.rawValue)
                                .font(.callout)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(task.difficulty.color)
                                .foregroundStyle(.white)
                                .clipShape(Capsule())
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: 0xF8F6ED))
                    )

                    // bloco checklist
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Checklist")
                            .font(.caption)
                            .fontWeight(.light)
                        
                        ForEach(Array(task.checklist.keys), id: \.self) { item in
                            Divider()
                            Text(item)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: 0xF8F6ED))
                    )


                }
                .padding()
            Spacer()
        }
        
        // !!!!!!!!! trocar !!!!!!!!!
        VStack {
            Button {
                modal.toggle()
            } label: {
                Text("Iniciar Tarefa")
                    .padding(.horizontal, 100)
                    .padding(.vertical, 15)
                    .background(Color(hex: 0x91A394))
                    .foregroundStyle(.white)
                    .cornerRadius(8)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .sheet(isPresented: $modal, content: {
            TaskNow(task: $task)})
        }
        .background(Color("BackgroundScreenColor"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Detalhes da Tarefa")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Text("Editar")
                        .foregroundColor(Color("AccentColor"))
                }
            }
        }
        
    }
}

struct TaskInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TaskInfoView(task: $task)
    }
}
