//
//  taskStyle.swift
//  chiron
//
//  Created by Laris on 16/04/25.
//

import Foundation
import SwiftUI

extension Category {
    var color: Color {
        switch self {
        case .estudos:
            return .purple
        case .lazer:
            return .blue
        case .faxina:
            return .orange
        case .social:
            return .pink
        case .atv_fisica:
            return .orange
        }
    }
}

extension Difficulty {
    var color: Color {
        switch self {
        case .facil:
            return .green
        case .medio:
            return .orange
        case .dificil:
            return .red
        }
    }
}
