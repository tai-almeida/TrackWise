//
//  TabBar.swift
//  chiron
//
//  Created by Aluno 45 on 16/04/25.
//

import SwiftUI

struct TabBar: View {
    
    @ObservedObject
    var week = Week(id: Week.exampleWeek.id,
                    date: Week.exampleWeek.date,
                    tasks: Week.exampleWeek.tasks,
                    events: Week.exampleWeek.events)
    
    /* TabBar com 3 elementos - planner, calendario e pendentes */
    var body: some View {
       
        TabView {
            PlannerView(week: week)
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
