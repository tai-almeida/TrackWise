//
//  TaskNow.swift
//  chiron
//
//  Created by Aluno 02 on 22/04/25.
//

import SwiftUI

var checklist: [String] =
    ["Revisar capítulo 2", "Fazer Exercícios", "Corrigir exercícios"]
var tarefa = "Estudar Cálculo"
var local = "Biblioteca Central"
var horario_ini = DateComponents(hour: 8, minute: 0)
var horario_fim = DateComponents(hour: 9, minute: 0)
var tempo_restante = 30



struct TaskNow: View {
    var body: some View {
        VStack (alignment: .leading) {
            
            VStack (alignment: .leading) {
                Text(tarefa)
                    .font(.title.bold())
                    .padding(.bottom, 10)
                
                Text(local)
                    .font(.headline)
                    .padding(.bottom, 5)
                
                Text("8:00 - 9:00")
                    .padding(.bottom, 5)
                
                Text("Tempo restante: \(tempo_restante) min")
                    .font(.subheadline)
                    .padding(.bottom, 10)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            Form {
                Section(header: Text("Checklist")) {
                    ForEach(checklist, id: \.self) { item in
                        Text(item)
                    }
                }
            }
            .frame(alignment: .topLeading)
        }
        .padding(.vertical)

    }
}



struct TaskNow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskNow()
        }
    }
}
