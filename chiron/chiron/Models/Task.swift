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
    case estudos = "Estudos"
    case lazer = "Lazer"
    case faxina = "Faxina"
    case social = "Social"
    case atv_fisica = "Atividade Física"
    var id: String { self.rawValue }
}
struct Task: Identifiable {
    let id = UUID()
    var title: String
    var location: String
    var date: Date
    var startTime: Date
    var endTime: Date
    var category: Category
    var difficulty: Difficulty
    var checklist: [String:Bool]
    var isCompleted: Bool
    var averageTime: Int //?
    
    init(title:String, location:String, date:Date, startTime:Date,
         endTime:Date, category:Category, difficulty:Difficulty, checklist:[String:Bool], isCompleted:Bool, averageTime:Int) {
        //self.id = id
        self.title = title
        self.location = location
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.category = category
        self.difficulty = difficulty
        self.checklist = checklist
        self.isCompleted = isCompleted
        self.averageTime = averageTime
    }
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
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: startTime)
    }
    static let exampleTask = Task(
        //id: 0,
        title: "Estudar Cálculo 1",
        location: "Biblioteca Central",
        date: Date(),
        startTime: Date(),
        endTime: Date().addingTimeInterval(3600),
        category: .estudos,
        difficulty: .dificil,
        checklist: ["Assistir aula":false, "Fazer exercícios":false, "Revisar":false],
        isCompleted: false,
        averageTime: 47
    )
    
    static let task2 = Task(
        id: 1,
        title: "Lavar Roupa",
        location: "Casa",
        date:  Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
        startTime: setTime(hour: 9, minute: 0),
        endTime: Date().addingTimeInterval(3600),
        category: .faxina,
        difficulty: .facil,
        checklist: ["Lavar Roupas" : false, "Estender Roupas": false],
        isCompleted: false,
        averageTime: 58)
}
func setTime(hour: Int, minute: Int) -> Date {
    var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    components.hour = hour
    components.minute = minute
    components.second = 0
    return Calendar.current.date(from:components)!
}
func convertsTime(duration: Int) -> String {
    /* Converte o tempo da tarefa de minutos para uma string no formato HhMIN*/
    let totalMinutes = duration
    let hours = totalMinutes / 60
    let minutes = totalMinutes % 60
    
    if hours > 0 {
        if minutes > 0 {
            return "\(hours)h\(minutes)"
        } else {
            return "\(hours)h"
        }
        
    } else {
        return "\(minutes)min"
    }
}


