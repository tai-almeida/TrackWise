//
//  ShapeColorfulBackground.swift
//  chiron
//
//  Created by Laris on 25/04/25.
//

import Foundation
import SwiftUI

struct ShapeColorfulStyle: ViewModifier {
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
