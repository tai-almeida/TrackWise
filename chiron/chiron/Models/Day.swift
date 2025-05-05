//
//  Day.swift
//  chiron
//
//  Created by Aluno 45 on 24/04/25.
//

import SwiftUI

class Day: Identifiable, ObservableObject {
    let id = UUID()
    var date: Date
    var name: String
    @Published
    var tasks: [Task]
    var events: [String]
    
    // variavel booleana que verifica se esta no dia de hoje
    var isToday: Bool {
        Calendar.current.isDate(date, inSameDayAs: Date())
    }
    
    init(name: String, tasks: [Task], events: [String]) {
        self.date = Date()
        self.name = name
        self.tasks = tasks
        self.events = events
    }
}
