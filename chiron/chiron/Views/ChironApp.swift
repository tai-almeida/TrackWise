//
//  chironApp.swift
//  chiron
//
//  Created by Aluno 02 on 14/04/25.
//

import SwiftUI

@main
struct chironApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TaskInfoView(task: Task.exampleTask)
                //EventInfoView(event: Event.exampleEvent)
                // TravelInfoView(travel: Travel.exampleTravel)

            }
        }
    }
}
