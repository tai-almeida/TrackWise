//
//  PlannerView.swift
//  chiron
//
//  Created by Aluno 41 on 15/04/25.
//
import SwiftUI
struct PlannerView: View {
    @State
      var navigateToAddItem:Bool = false
    // by default, the first tab selected is the planner (main frame)
    var week: Week
    var body: some View {
        ZStack {
            Color("BackgroundScreenColor").ignoresSafeArea()
            NavigationView {
                VStack(alignment: .leading) {
                    // tela scrolavel com os dias da semana
                    ScrollView {
                        VStack(alignment: .leading) {
                            // "Hoje" com destaque na tela
                            Text("Hoje")
                                .font(.title.bold())
                                .padding(.vertical, 2)
                                .padding(.top, 5)
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 10)
                            
                            ForEach(week.days) { day in
                                // imprime o dia da semana e a data abaixo
                                Text(day.name)
                                    .padding(.top, 5)
                                    .font(.body.bold())
                                    .multilineTextAlignment(.leading)
                                // impressao de cada evento do dia
                                VStack (alignment: .leading){
                                    // cada evento separado por um divisor
                                    ForEach(day.events, id: \.self) { events in
                                        Divider()
                                            .padding(.horizontal, 20)
                                        Text(events)
                                            .padding(.horizontal, 20)
                                            .padding(.bottom, 20)
                                    }
                                }
                                // impressao das tarefas do dia
                                VStack (alignment: .leading) {
                                    if !day.tasks.isEmpty {
                                    Text("Atividades")
                                        .padding(.top, 20)
                                        .font(.body.bold())
                                        .multilineTextAlignment(.leading)
                                    Section {
                                        ForEach(day.tasks, id: \.id) { task in
                                            HStack {
                                                // cada tarefa separada por um divisor abaixo do horario setado (formatado)
                                                Spacer()
                                                Text(task.formattedTime)
                                                    .padding(.trailing, 10)
                                            }
                                            Divider()
                                                NavigationLink(destination: TaskInfoView(task: task)) {
                                                    HStack {
                                                        Rectangle()
                                                            .foregroundColor(task.category.color)
                                                            .frame(width:10)
                                                        VStack(alignment: .leading) {
                                                            // nome da tarefa
                                                            Text(task.title)
                                                                .padding(.top, 10)
                                                                .foregroundStyle(.black)
                                                                .padding(.leading, 5)
                                                            // tag de dificuldade
                                                            Text(task.difficulty.rawValue)
                                                                .font(.system(size:12))
                                                                .padding(.horizontal, 10)
                                                                .padding(.vertical, 4)
                                                                .background(task.difficulty.color)
                                                                .foregroundStyle(.white)
                                                                .clipShape(Capsule())
                                                        }
                                                        .padding(.bottom, 5)
                                                        Spacer()
                                                        VStack(alignment: .trailing) {
                                                            // simbolo de inicio da tarefa
                                                            Image(systemName: "play.fill")
                                                                .padding(.horizontal, 10)
                                                                .padding(.vertical, 4)
                                                                .background(Color("AccentColor"))
                                                                .foregroundStyle(.white)
                                                                .clipShape(Capsule())
                                                            // tag com o tempo convertido para HhMIN
                                                            Text(convertsTime(duration: task.averageTime))
                                                                .font(.system(size:12))
                                                                .padding(.horizontal, 10)
                                                                .padding(.vertical, 4)
                                                                .background(Color(hex: 0xEFE8D8))
                                                                .foregroundStyle(.black)
                                                                .clipShape(Capsule())
                                                        }
                                                        .padding(.trailing, 5)
                                                    }
                                                }
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .background(Color(hex: 0xF8F6ED))
                                                .cornerRadius(8)
                                                .padding(.horizontal, 5)
                                            }
                                        }
                                    }
                                }
                            }
                            
                            // insere + na toolbar para ir para tela de AddTask
                            .padding(.horizontal, 10)
                            NavigationLink.init("",
                                                destination: AddItemView(),
                                                isActive: $navigateToAddItem)
                                    }.navigationTitle("Minha Rotina").navigationBarTitleDisplayMode(.inline)
                                      .frame(maxWidth: .infinity, maxHeight: .infinity)
                                      .background(Color("BackgroundScreenColor"))
                                      .toolbar {
                                        ToolbarItem(placement: .navigationBarTrailing) {
                                          Button(action: {
                                            navigateToAddItem = true
                                          }) {
                                            Text("+")
                                              .foregroundColor(Color("AccentColor"))
                                          }
                                        }
                                      }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundScreenColor"))
        }
    }
    struct PlannerView_Previews: PreviewProvider {
        static var previews: some View {
            PlannerView(week: Week.exampleWeek)
        }
    }
}
