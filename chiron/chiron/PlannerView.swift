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
        VStack {
            Text("Planner")
                .padding()
            
            Spacer()
            
            TabBar(selectedTab: $selectedTab)
    }
}

struct PlannerView_Previews: PreviewProvider {
    static var previews: some View {
        PlannerView()
    }
}
}
