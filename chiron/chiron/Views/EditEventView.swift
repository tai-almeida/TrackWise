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


    init(event: Binding<Event>, eventData: Event){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear

        self._event = event
        self._editableEvent = State(initialValue: eventData)
    }

    var body: some View {
        
        // background
        ZStack {
            Color("BackgroundScreenColor").ignoresSafeArea()
                            
            Form {
                
                Section {
                    TextField("Titulo", text: $editableEvent.title)
                    TextField("Localização", text: $editableEvent.location)
                }
                .listRowBackground(Color(.secondarySystemBackground))

    
                Section {
                    DatePicker("Data",
                               selection: $editableEvent.date,
                               in: Date()...,
                               displayedComponents: .date
                    )
                }
                .listRowBackground(Color(.secondarySystemBackground))
            }

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

