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
    var body: some View {
        NavigationView {
            VStack {
                Text("Tela do Planner")
                    .padding()
                NavigationLink.init("Clique aqui", destination: Text("Proxima Tela").navigationTitle("Boas vindas a nova tela!"))
                
                Spacer()
                
                //TabBar()
            }.navigationTitle("Planner")
        }
    }
    
    struct PlannerView_Previews: PreviewProvider {
        static var previews: some View {
            PlannerView()
        }
    }
}
