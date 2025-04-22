//
//  TarefaInfoView.swift
//  chiron
//
//  Created by Laris on 15/04/25.
//

import Foundation
import SwiftUI

struct TaskInfoView: View {
    var task: Task
    
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
                    .padding()
                    
                    // bloco infos secundarias
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
                            .fill(Color(hex: 0xF1ECDB))
                    )
                    .padding(.bottom)
                    
                    // bloco checklist
                    Text("Checklist")
                        .font(.caption)
                        .fontWeight(.light)
                        .padding(.horizontal)
                    VStack (alignment: .leading){
                        ForEach(task.checklist, id: \.self) { item in
                            Divider()
                            Text(item)
                        }
                    }
                    .padding([.horizontal, .bottom])
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: 0xF1ECDB))
                    )
                
                }
                
            }
            Spacer()

            NavigationLink(destination: IniciarTaskView()) {
                Text("Começar Tarefa")
                    .padding(.horizontal, 100)
                    .padding(.vertical, 15)
                    .background(Color(hex: 0x91A394))
                    .foregroundStyle(.white)
                    .cornerRadius(8)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
        }
        .background(Color(hex: 0xEFE8D8))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Detalhes da Tarefa")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Text("Editar")
                        .foregroundColor(Color(hex: 0x91A394))
                }
            }
        }
    }
}

struct TaskInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TaskInfoView(task: Task.exampleTask)
    }
}
