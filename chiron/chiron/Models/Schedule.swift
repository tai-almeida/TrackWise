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
    
    init() {
        self.tasks = []
    }
    
    func dateTasks(data: Date) -> [Task] {
    // retorna todas as tarefas de "data"
        let calendar = Calendar.current
        return tasks.filter {
            calendar.isDate($0.date, inSameDayAs: data)
        }
    }
    
    func getWeekDay(date: Date) -> String {
        let f = DateFormatter()

        return f.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
    }
    
    
}
