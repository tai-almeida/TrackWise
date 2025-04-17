//
//  Week.swift
//  chiron
//
//  Created by Aluno 45 on 17/04/25.
//

import Foundation


var task1 = Task(id: 0, title: "Estudar Calculo", location: "Biblioteca Central", date: Date(), startTime: Date(), endTime: Date().addingTimeInterval(3600), category: .estudos, difficulty: .dificil, checklist: ["Assistir aula":false, "Fazer exercícios":false, "Revisar":false], isCompleted: false, averageTime: 47)

struct Week: Identifiable {
    var id: Int
    var date: Date
    let days: [String] = ["Segunda-feira", "Terça-feira","Quarta-feira","Quinta-feira","Sexta-feira","Sábado","Domingo"]
    var tasks: [Task]
    var events: [String]
    
    static let exampleWeek = Week(
        id: 0,
        date: Date(),
        tasks: [task1],
        events: ["Aniversário de Cont", "Prova de Física", "Checkpoint Design"]
    )

}
