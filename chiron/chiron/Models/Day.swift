//
//  Day.swift
//  chiron
//
//  Created by Aluno 45 on 24/04/25.
//

import SwiftUI

struct Day: Identifiable {
    let id = UUID()
    var date: Date
    var name: String
    var tasks: [Task]
    var events: [String]
    
    // variavel booleana que verifica se esta no dia de hoje
    var isToday: Bool {
        Calendar.current.isDate(date, inSameDayAs: Date())
    }
    
    init(name: String, tasks: [Task], events: [String], date: Date) {
        self.date = date
        self.name = name
        self.tasks = tasks
        self.events = events
        //self.isToday = true
    }
}
