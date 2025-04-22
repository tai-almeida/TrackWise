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
    var time: Date
    var date: Date
    
    init(id: Int, title: String, time: Date, date: Date) {
        self.id = id
        self.title = title
        self.time = time
        self.date = date
    }
    
    var formattedData: String {
        let formatter = DateFormatter()
        formatter.dateFormat="dd/MM/YYYY"
        return formatter.string(from: date)
    }
}
