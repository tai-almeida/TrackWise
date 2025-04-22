//
//  InfoView.swift
//  chiron
//
//  Created by Laris on 22/04/25.
//

import SwiftUI

struct InfoView: View {
    let item: RoutineItem
    var body: some View {
        switch item {
        case .Task: {
            TaskInfoView()
        }
        case .Event: {
            EventInfoView()
        }
        case .Travel: {
            TravelInfoView()
        }
    }
}
