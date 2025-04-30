//
//  TabBar.swift
//  chiron
//
//  Created by Aluno 45 on 16/04/25.
//

import SwiftUI

struct TabBar: View {
    
    @StateObject
//        var week = Week(id: Week.exampleWeek.id,
//                        startDate: Week.exampleWeek.startDate,
//                        days: Week.exampleWeek.days)
    var schedule = Schedule()
    
    /* TabBar com 3 elementos - planner, calendario e pendentes */
    var body: some View {
       
        TabView {
            PlannerView()
                .tabItem{
                    Label("Planner", systemImage: "book")}

//            Text("Tela 2")
//                .tabItem{
//                    Label("Calendário", systemImage: "calendar")}
            
            
            
            Text("Tela 2")
                .tabItem{
                    Label("Pendentes", systemImage: "clock.badge.exclamationmark")}
        }
        // altera cor do item selecionado na TabBar
        .accentColor(Color("AccentColor"))
        .environmentObject(schedule)
    }
}

    
struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
