//
//  colorExtension.swift
//  chiron
//
//  Created by Laris on 16/04/25.
//

import Foundation
import SwiftUI

// referencia: medium
extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}

let backgroundGradient = LinearGradient(
    colors: [Color(hex: 0xEFE8D8), Color(hex: 0xEFE8D8, opacity: 0.5)],
    startPoint: .top, endPoint: .bottom)
