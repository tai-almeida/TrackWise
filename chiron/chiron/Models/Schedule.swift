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
        self.tasks = [Task.exampleTask, Task.task2]
        self.events = [Event.exampleEvent, Event.example2]
    }
    
    func dateTasks(data: Date) -> [Int] {
    // retorna todas as tarefas de "data"
        let calendar = Calendar.current
        return tasks.indices.filter {
            calendar.isDate(tasks[$0].date, inSameDayAs: data)
        }
    }
    
    func dateEvents(data: Date) -> [Int] {
    // retorna todas as tarefas de "data"
        let calendar = Calendar.current
        return events.indices.filter {
            calendar.isDate(events[$0].date, inSameDayAs: data)
        }
    }
    
    func getWeekDay(date: Date) -> String {
        let f = DateFormatter()
        return f.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
    }
    
    
}
