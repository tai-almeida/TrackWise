//
//  GreenButton.swift
//  chiron
//
//  Created by Larissa on 24/04/25.
//

import SwiftUI

struct GreenButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .padding(.horizontal, 100)
            .padding(.vertical, 15)
            .background(Color("AccentColor"))
            .foregroundStyle(.white)
            .cornerRadius(8)
            .frame(maxWidth: .infinity, alignment: .center)
    }
}
