//
//  EditEventView.swift
//  chiron
//
//  Created by Larissa on 06/05/25.
//

import SwiftUI

struct EditEventView: View {
    
    @Binding
    var event:Event
    
    var index:Int = 0
    
    @State
    var editableEvent:Event
        
    @Environment(\.dismiss) var dismiss

    @EnvironmentObject var schedule: Schedule

    init(event: Binding<Event>, eventData: Event){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear

        self._event = event
        self._editableEvent = State(initialValue: eventData)
    }

    var body: some View {
        
        // background
        ZStack {
            Color(.secondarySystemBackground).ignoresSafeArea()
                            
            Form {
                
                Section {
                    TextField("Nome do Evento", text: $editableEvent.title)
                    TextField("Localização", text: $editableEvent.location)
                }
                .listRowBackground(Color(.white))

    
                Section {
                    DatePicker("Data",
                               selection: $editableEvent.date,
                               in: Date()...,
                               displayedComponents: .date
                    )
                }
                .listRowBackground(Color(.white))
                
                Section {
                    Button(action: {
                        if let index = schedule.events.firstIndex(where: { $0.id == event.id }) {
                            schedule.events.remove(at: index)
                            dismiss()
                        } else {
                            print("Não achei!")
                        }
                    }) {
                        Text("Excluir Evento")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.red)
                    }
                }
                .listRowBackground(Color(.secondarySystemBackground))

            }
            .background(Color(.secondarySystemBackground))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    event = editableEvent
                    dismiss()
                }) {
                    Text("Ok")
                        .foregroundColor(Color("AccentColor"))
                    }
                }
            }
        }
    }
}

