//
//  TabBar.swift
//  chiron
//
//  Created by Aluno 45 on 16/04/25.
//

import SwiftUI

struct TabBar: View {
    
    @StateObject
    var schedule = Schedule()
    
    /* TabBar com 3 elementos - planner, calendario e pendentes */
    var body: some View {
       
        //TabView {
            PlannerView()
        .environmentObject(schedule)
    }
}

    
struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

