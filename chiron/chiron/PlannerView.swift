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
    @State var selectedTab: Tabs = .planner
    var week: Week
    var body: some View {
        ZStack {
            screenColor.ignoresSafeArea()
            
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
                                    Text(item)
                                }
                                
                            }
                            
                        }
                    }
                    
                }.navigationTitle("Minha Rotina").navigationBarTitleDisplayMode(.inline)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(screenColor)
                    
            }
            
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(screenColor)
            .padding()
        }
    }
    
    struct PlannerView_Previews: PreviewProvider {
        static var previews: some View {
            PlannerView(week: Week.exampleWeek)
        }
    }
}
