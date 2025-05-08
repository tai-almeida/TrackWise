//
//  EventInfo .swift
//  chiron
//
//  Created by Laris on 22/04/25.
//

import SwiftUI

struct EventInfoView: View {
    
    @Binding
    var originalEvent: Event
    
    var event: Event
    
    @State
    var navigateToEditEventView: Bool = false
    
//    @EnvironmentObject
//    var week: Week
    
    var body: some View {
        
        VStack (alignment: .leading){
            
            ScrollView {
                VStack(alignment: .leading) {
                    
                    // bloco infos principais
                    VStack (alignment: .leading){
                        Text(event.title)
                            .font(.title.bold())
                            .padding(.bottom, 10)
                        
                        Text(event.location)
                            .font(.headline)
                            .padding(.bottom, 5)
                    }
                    .padding()
                    
                    // bloco infos secundarias
                    VStack {
                        HStack {
                            Text("Data")
                            Spacer()
                            Text(event.formattedData)
                                .foregroundStyle(.secondary)
                        }
                                            
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.secondarySystemBackground))
                    )
                    .padding(.bottom)
                }
                
            }
            Spacer()
        }
        .background(Color("BackgroundScreenColor"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Detalhes do Evento")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Text("Editar")
                        .foregroundColor(Color("AccentColor"))
                }
            }
        }
    }
}

//struct EventInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventInfoView(originalEvent: Event.exampleEvent,
//                      event: Event.exampleEvent)
//    }
//}
