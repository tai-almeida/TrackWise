//
//  Schedule.swift
//  chiron
//
//  Created by Aluno 45 on 30/04/25.
//

import SwiftUI

class Schedule: ObservableObject {
    @Published
    var tasks: [Task]
    @Published
    var events: [Event]
    
    init() {
        self.tasks = [Task.exampleTask]
        self.events = [Event.exampleEvent]
    }
    
    func dateTasks(data: Date) -> [Task] {
    // retorna todas as tarefas de "data"
        let calendar = Calendar.current
        return tasks.filter {
            calendar.isDate($0.date, inSameDayAs: data)
        }
    }
    
    func dateEvents(data: Date) -> [Event] {
    // retorna todas as tarefas de "data"
        let calendar = Calendar.current
        return events.filter {
            calendar.isDate($0.date, inSameDayAs: data)
        }
    }
    
    func getWeekDay(date: Date) -> String {
        let f = DateFormatter()
        return f.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
    }
    
    
}
