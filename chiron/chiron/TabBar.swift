//
//  TabBar.swift
//  chiron
//
//  Created by Aluno 45 on 16/04/25.
//

import Foundation
import SwiftUI

enum Tabs: Int {
    case planner = 0
    case calendar = 1
    case perfil = 2
}

// Declares AppColor as a global variable
let AppColor = Color(
                red: 102/255,
                green: 130/255,
                blue: 125/255);

let inactiveTabColor: Color = Color(red: 0.7, green: 0.7, blue: 0.7)


struct TabBar: View {
    
   // @Binding var selectedTab: Tabs          // verifies wich tab bar button was selected
   // @State var isLinkActive: Bool = false   // verifies if the button was clicked
    
    var body: some View {
       
        TabView {
            PlannerView()
                .tabItem{
                    Label("Planner", systemImage: "book")}

            Text("Tela 2")
                .tabItem{
                    Label("Calendário", systemImage: "calendar")}
            

            Text("Tela 3")
                .tabItem{
                    Label("Pendentes", systemImage: "clock.badge.exclamationmark")}
                        }
    }
}

    
struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
       // TabBar(selectedTab: .constant(.planner))
        TabBar()
    }
}
