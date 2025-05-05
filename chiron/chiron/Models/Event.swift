//
//  Event.swift
//  chiron
//
//  Created by Laris on 22/04/25.
//

import Foundation

struct Event: Identifiable, Hashable {
    let id: Int
    var title: String
    var location: String
    var date: Date
    
    init(id: Int, title: String, location: String, date: Date) {
        self.id = id
        self.title = title
        self.location = location
        self.date = date
    }
    
    var formattedData: String {
        let formatter = DateFormatter()
        formatter.dateFormat="dd/MM/YYYY"
        return formatter.string(from: date)
    }
    
    static let exampleEvent = Event(
        id: 0,
        title: "Aniversário do Cont",
        location: "Morro do Bombom",
        date: Date()
    )
}
