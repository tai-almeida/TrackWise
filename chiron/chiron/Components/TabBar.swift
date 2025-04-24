//
//  TabBar.swift
//  chiron
//
//  Created by Aluno 45 on 16/04/25.
//

import SwiftUI

struct TabBar: View {
    /* TabBar com 3 elementos - planner, calendario e pendentes */
    var body: some View {
       
        TabView {
            PlannerView(week:Week.exampleWeek)
                .tabItem{
                    Label("Planner", systemImage: "book")}

            Text("Tela 2")
                .tabItem{
                    Label("Calendário", systemImage: "calendar")}
            

            Text("Tela 3")
                .tabItem{
                    Label("Pendentes", systemImage: "clock.badge.exclamationmark")}
        }
        // altera cor do item selecionado na TabBar
        .accentColor(Color("AccentColor"))
    }
}

    
struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
