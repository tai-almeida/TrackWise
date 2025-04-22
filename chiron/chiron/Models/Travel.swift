//
//  Travel.swift
//  chiron
//
//  Created by Laris on 22/04/25.
//

import Foundation

struct Travel: Identifiable {
    let id: Int
    var title: String
    var startTime: Date
    var duration: Int //?
    var date: Date
    
    init(id: Int, title: String, startTime: Date, duration: Int, date: Date) {
        self.id = id
        self.title = title
        self.startTime = startTime
        self.duration = duration
        self.date = date
    }
    
    var formattedData: String {
        let formatter = DateFormatter()
        formatter.dateFormat="dd/MM/YYYY"
        return formatter.string(from: date)
    }
    
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: startTime)
    }
    
    static let exampleTravel = Travel(
        id: 0,
        title: "Deslocamento",
        startTime: Date(),
        duration: 15,
        date: Date()
    )
}
