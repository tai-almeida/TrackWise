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
    
    @Binding var selectedTab: Tabs          // verifies wich tab bar button was selected
    @State var isLinkActive: Bool = false   // verifies if the button was clicked
    
    var body: some View {
       
        HStack (alignment: .center, spacing: 56){
            Button {
                // goes to planner screen
                selectedTab = .planner
            } label: {
                
                    VStack (alignment: .center, spacing: 0){
                       
                      Image(systemName: "book")
                            //.resizable()
                            //.scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(selectedTab == .planner ? AppColor : inactiveTabColor)
                        Text("Planner")
                            .foregroundColor(selectedTab == .planner ? AppColor : inactiveTabColor)
                    }
            }
            Button {
                // goes to calendar screen
                selectedTab = .calendar
            } label: {

                
                VStack (alignment: .center, spacing: 0){
                    Image(systemName: "calendar")
                        //.resizable()
                        //.scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(selectedTab == .calendar ? AppColor : inactiveTabColor)
                    Text("Calendário")
                        .foregroundColor(selectedTab == .calendar ? AppColor : inactiveTabColor)
                }
                
            }
            Button {
                // goes to profile screen
                selectedTab = .perfil
            } label: {
                VStack (alignment: .center, spacing: 0){
                    Image(systemName: "person")
                        //.resizable()
                        //.scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(selectedTab == .perfil ? AppColor : inactiveTabColor)
                    Text("Perfil")
                        .foregroundColor(selectedTab == .perfil ? AppColor : inactiveTabColor)
                }
                
            }
        }

    }
}

    
struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(selectedTab: .constant(.planner))
    }
}
