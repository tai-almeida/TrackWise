//
//  ShapeColorfulBackground.swift
//  chiron
//
//  Created by Laris on 25/04/25.
//

import Foundation
import SwiftUI

struct ColorfulShapeStyle: ViewModifier {
    var backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.callout)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(backgroundColor)
            .foregroundStyle(.white)
            .clipShape(Capsule())
    }
}

// Define a cor do GroupBox ao adicionar eventos
struct WhiteGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            configuration.content
                .padding()
                .background(Color.white)
                .cornerRadius(8)
        }
    }
}
