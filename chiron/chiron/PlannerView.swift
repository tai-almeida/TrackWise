//
//  PlannerView.swift
//  chiron
//
//  Created by Aluno 41 on 15/04/25.
//

import Foundation
import SwiftUI


struct PlannerView: View {
    var body: some View {
        HStack (alignment: .center, spacing: 56){
            Button {
            } label: {
                VStack (alignment: .center, spacing: 4){
                  Image(systemName: "book.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(
                            Color(
                            red: 102/255,
                            green: 130/255,
                            blue: 125/255)
                        )
                    Text("Planner")
                        .foregroundStyle(.green)
                }
            }
            Button {
                
            } label: {
                VStack (alignment: .center, spacing: 4){
                    Image(systemName: "calendar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.green)
                    Text("Calendário")
                        .foregroundStyle(.green)
                }
                
            }
            Button {
                
            } label: {
                VStack (alignment: .center, spacing: 4){
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.green)
                    Text("Perfil")
                        .foregroundStyle(.green)
                }
                
            }
    }
}

struct PlannerView_Previews: PreviewProvider {
    static var previews: some View {
        PlannerView()
    }
}
}
