//
//  example_task.swift
//  chiron
//
//  Created by Laris on 15/04/25.
//

import Foundation

// CaseIterable permite acessar os valores como lista,
// necessario para criar a seleçao na criaçao de Task
enum Difficulty: String, CaseIterable, Identifiable {
    case facil = "Fácil"
    case medio = "Média"
    case dificil = "Difícil"
    
    var id: String { self.rawValue } // rawValue pega o valor (a string)
}

enum Category: String, CaseIterable, Identifiable {
    case estudos, lazer, faxina, social
    
    var id: String { self.rawValue }
}

struct Task: Identifiable {
    let id: Int
    var title: String
    var location: String
    var date: Date
    var startTime: Date
    var endTime: Date
    var category: Category
    var difficulty: Difficulty
    var checklist: [String]
    var isCompleted: Bool
    var averageTime: Int //?
    
    var formattedData: String {
        let formatter = DateFormatter()
        formatter.dateFormat="dd/MM/YYYY"
        return formatter.string(from: startTime)
    }
    
    var formattedRangeTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat="HH:mm"
        let start = formatter.string(from: startTime)
        let end = formatter.string(from: endTime)
        return "\(start) - \(end)"
    }
    
    static let exampleTask = Task(
        id: 0,
        title: "Estudar Cálculo 1",
        location: "Biblioteca Central",
        date: Date(),
        startTime: Date(),
        endTime: Date().addingTimeInterval(3600),
        category: .estudos,
        difficulty: .dificil,
        checklist: ["Assistir aula", "Fazer exercícios", "Revisar"],
        isCompleted: false,
        averageTime: 47
    )
}
