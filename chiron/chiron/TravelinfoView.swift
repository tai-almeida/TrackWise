//
//  EventInfo .swift
//  chiron
//
//  Created by Laris on 22/04/25.
//

import SwiftUI

struct TravelInfo: View {
    var travel: Travel
    
    var body: some View {
        
        VStack (alignment: .leading){
            
            ScrollView {
                VStack(alignment: .leading) {
                    
                    
                    // bloco infos principais
                    VStack (alignment: .leading){
                        Text(travel.title)
                            .font(.title.bold())
                            .padding(.bottom, 10)
                        
                        Text(travel.time)
                            .font(.headline)
                            .padding(.bottom, 5)
                    }
                    .padding()
                    
                    // bloco infos secundarias
                    VStack {
                        HStack {
                            Text("Data")
                            Spacer()
                            Text(travel.formattedData)
                        }
                                            
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: 0xF1ECDB))
                    )
                    .padding(.bottom)
                }
                
            }
            Spacer()
        }
        .background(Color(hex: 0xEFE8D8))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Detalhes do Deslocamento")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Text("Editar")
                        .foregroundColor(Color(hex: 0x91A394))
                }
            }
        }
    }
}
