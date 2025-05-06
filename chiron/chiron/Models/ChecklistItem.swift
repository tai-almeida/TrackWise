//
//  ChecklistItem.swift
//  chiron
//
//  Created by Larissa on 29/04/25.
//

import Foundation
import SwiftUI

struct ChecklistItem: Identifiable, Equatable {
    let id: UUID = UUID()
    var title: String
    var isDone: Bool
    var offset: CGSize = .zero
    
    init(title: String, isDone: Bool) {
        self.title = title
        self.isDone = isDone
    }
}
