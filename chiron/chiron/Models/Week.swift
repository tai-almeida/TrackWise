//
//  Week.swift
//  chiron
//
//  Created by Aluno 45 on 17/04/25.
//
import Foundation
// tasks de exemplo (estaticas)
var task1 = Task(
            //id: 0,
            title: "Estudar Calculo",
            location: "Biblioteca Central",
            date: Date(),
            startTime: setTime(hour: 8, minute: 0),
            endTime: Date().addingTimeInterval(3600),
            category: .estudos,
            difficulty: .dificil,
            checklist: ["Assistir aula":false, "Fazer exercícios":false, "Revisar":false],
            isCompleted: false,
            averageTime: 47)
var task2 = Task(
            //id: 1,
            title: "Lavar Roupa",
            location: "Casa",
            date: Date(),
            startTime: setTime(hour: 9, minute: 0),
            endTime: Date().addingTimeInterval(3600),
            category: .faxina,
            difficulty: .facil,
            checklist: ["Lavar Roupas" : false, "Estender Roupas": false],
            isCompleted: false,
            averageTime: 58)
var task3 = Task(
            //id: 2,
            title: "Academia",
            location: "Academia",
            date: Date(),
            startTime: setTime(hour: 10, minute: 0),
            endTime: Date().addingTimeInterval(3600),
            category: .atv_fisica,
            difficulty: .medio,
            checklist: ["Treinar" : false, "Tomar banho": false],
            isCompleted: false,
            averageTime: 80)


var segunda = Day(name:"Segunda-feira", tasks:[task1, task2], events:["Aniversário de Cont", "Prova de Física", "Checkpoint Design"])
var terca = Day(name:"Terça-feira", tasks:[task1], events:["SwiftUI Session"])
var quarta = Day(name:"Quarta-feira", tasks:[task3], events:["Entrega projeto MC202", "Palestra Design"])
var quinta = Day(name:"Quinta-feira", tasks:[task2, task3], events:[])
var sexta = Day(name:"Sexta-feira", tasks:[task1, task2, task3], events:["Festa Mãe"])
var sabado = Day(name:"Sábado", tasks:[task3], events:[])
var domingo = Day(name:"Domingo", tasks:[], events:["Entrega projeto final MC613"])

class Week: Identifiable, ObservableObject {
    var id: Int
    var startDate: Date
    @Published
    var tasks: [Task]
    //var days: [Day]
    
    
    static let exampleWeek = Week(
        id: 0,
        startDate: Date(),
        tasks: []
        //days: [segunda, terca, quarta, quinta, sexta, sabado, domingo]
    )
    
    init(id:Int, startDate: Date, tasks:[Task]) {
        self.id = id
        self.startDate = startDate
        self.tasks = tasks
    }

}











