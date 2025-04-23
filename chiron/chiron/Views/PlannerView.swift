//
//  PlannerView.swift
//  chiron
//
//  Created by Aluno 41 on 15/04/25.
//

import Foundation
import SwiftUI


struct PlannerView: View {
    
    // by default, the first tab selected is the planner (main frame)
    //@State var selectedTab: Tabs = .planner
    var week: Week
    var body: some View {
        ZStack {
            Color("BackgroundScreenColor").ignoresSafeArea()
            
            NavigationView {
                
                VStack(alignment: .leading) {
                    
                    // tela scrolavel com os dias da semana
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text("Hoje")
                                .font(.title.bold())
                                .padding(.bottom, 2)
                                .padding(.trailing, 277)
                                .multilineTextAlignment(.leading)
                                
                            
                            Text("Segunda-Feira, 10 de abril")
                                .font(.body.bold())
                                //.padding(.top, 1)
                                //.padding(.leading, 5)
                                .multilineTextAlignment(.leading)
                            
                            // impressao de cada evento do dia
                            VStack (alignment: .leading){
                                
                                ForEach(week.events, id: \.self) { item in
                                    Divider()
                                        .padding(.horizontal, 20)
                                    //Rectangle()
                                        //.foregroundColor(Color(hex: 0xFCFFEF))
                                        //.cornerRadius(10)
                                        //.padding(.leading, 20)
                                    //.padding(.trailing, 20)
                                    Text(item)
                                        .padding(.horizontal, 20)
                                    
                                        
                                }
                            }
                            
                            // impressao das tarefas do dia
                            VStack (alignment: .leading) {
                                Text("Atividades")
                                    .padding(.top, 20)
                                    .font(.body.bold())
                                    .multilineTextAlignment(.leading)
                                
                                Section {
                                    ForEach(week.tasks, id: \.id) { task in
                                        HStack {
                                            Spacer()
                                            Text(task.formattedTime)
                                                .padding(.trailing, 10)
                                            
                                        }
                                        
                                        Divider()
                                            //.padding(.horizontal, 10)
                                        
                                        
                                        NavigationLink(destination: TaskInfoView(task: task)) {
                                            HStack {
                                                Rectangle()
                                                    .foregroundColor(task.category.color)
                                                    .frame(width:10)
                                                
                                                VStack(alignment: .leading) {
                                                    Text(task.title)
                                                        //.padding(.horizontal, 100)
                                                        .padding(.top, 10)
                                                        .foregroundStyle(.black)
                                                        .padding(.leading, 5)
                                                    
                                                    Text(task.difficulty.rawValue)
                                                        .font(.system(size:12))
                                                        .padding(.horizontal, 10)
                                                        .padding(.vertical, 4)
                                                        .background(task.difficulty.color)
                                                        .foregroundStyle(.white)
                                                        .clipShape(Capsule())
                                                }
                                                .padding(.bottom, 5)
                                            }
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color(hex: 0xF8F6ED))
                                        .cornerRadius(8)
                                        .padding(.horizontal, 10)
                                    }
                                    .padding(.horizontal, 10)
                                }
                            }
                                
                        }
                    }
                    
                    
                }.navigationTitle("Minha Rotina").navigationBarTitleDisplayMode(.inline)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("BackgroundScreenColor"))
                    
            }
            
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundScreenColor"))
            .padding()
        }
    }
    
    struct PlannerView_Previews: PreviewProvider {
        static var previews: some View {
            PlannerView(week: Week.exampleWeek)
        }
    }
}
