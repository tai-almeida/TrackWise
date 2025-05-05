//
//  Week.swift
//  chiron
//
//  Created by Aluno 45 on 17/04/25.
//

import Foundation

// tasks de exemplo (estaticas)
var task1 = Task(
            id: 0,
            title: "Estudar Calculo",
            location: "Biblioteca Central",
            date: Date(),
            startTime: setTime(hour: 8, minute: 0),
            endTime: Date().addingTimeInterval(3600),
            category: .estudos,
            difficulty: .dificil,
            checklist: [
                ChecklistItem(title: "Assistir aula", isDone: true),
                ChecklistItem(title: "Fazer exercícios", isDone: false),
                ChecklistItem(title: "Revisar", isDone: false)
            ],
            isCompleted: false,
            averageTime: 47)

var task2 = Task(
            id: 1,
            title: "Lavar Roupa",
            location: "Casa",
            date: Date(),
            startTime: setTime(hour: 9, minute: 0),
            endTime: Date().addingTimeInterval(3600),
            category: .faxina,
            difficulty: .facil,
            checklist: [
                ChecklistItem(title: "Lavar Roupas", isDone: false),
                ChecklistItem(title: "Estender Roupas", isDone: false)
            ],
            isCompleted: false,
            averageTime: 58)

var task3 = Task(
            id: 2,
            title: "Academia",
            location: "Academia",
            date: Date(),
            startTime: setTime(hour: 10, minute: 0),
            endTime: Date().addingTimeInterval(3600),
            category: .atv_fisica,
            difficulty: .medio,
            checklist: [
                ChecklistItem(title: "Treinar", isDone: false),
                ChecklistItem(title: "Tomar banho", isDone: false)
            ],
            isCompleted: false,
            averageTime: 80)

class Week: Identifiable, ObservableObject {
    var id: Int
    var date: Date
    let days: [String] = ["Segunda-feira", "Terça-feira","Quarta-feira","Quinta-feira","Sexta-feira","Sábado","Domingo"]
    @Published
    var tasks: [Task]
    var events: [String]
    
    static let exampleWeek = Week(
        id: 0,
        date: Date(),
        tasks: [task1, task2, task3],
        events: ["Aniversário de Cont", "Prova de Física", "Checkpoint Design"]
    )
    
    init(id:Int, date:Date, tasks: [Task], events: [String] = exampleWeek.events) {
        self.id = id
        self.date = date
        self.tasks = tasks
        self.events = events
    }

}
