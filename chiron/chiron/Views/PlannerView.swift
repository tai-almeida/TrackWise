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
    @EnvironmentObject
    //var week: Week
    var schedule: Schedule
    
    @State private var currentDate = Date()

//    init() {
//            let appearance = UINavigationBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.backgroundColor = UIColor(Color("AccentColor")).toUIColor(color: Color("AccentColor"))
//            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//
//            UINavigationBar.appearance().standardAppearance = appearance
//            UINavigationBar.appearance().scrollEdgeAppearance = appearance
//            UINavigationBar.appearance().compactAppearance = appearance
//            UINavigationBar.appearance().tintColor = .white
//        }
    
    
    
    var body: some View {
        ZStack {

            Color(.secondarySystemBackground).ignoresSafeArea()
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
                                //.padding(.leading, 10)
                            
                            // começa no dia de hoje e percorre os próximos 7 dias
                            ForEach((0..<7), id: \.self) { i in
                                let day = Calendar.current.date(byAdding: .day, value: i, to: Date())!
                                Text(schedule.getWeekDay(date: day))
                                    .padding(.top, 5)
                                    .font(.system(size: 20, weight: .bold))
                                    //.font(.bold)
                                    //.font(.body.bold())
                                    .multilineTextAlignment(.leading)
                                
                                VStack (alignment: .leading){
                                // cada evento separado por um divisor
                                    ForEach(schedule.dateEvents(data: day), id: \.self) { index in
                                        let event = schedule.events[index]
                                        Divider()
                                        NavigationLink(destination: EventInfoView(originalEvent: $schedule.events[index],
                                                                                 event: event)){
                                            
                                            //.padding(.horizontal, 20)
                                            
                                            // verifica se ha eventos na data analisada
                                            if !schedule.dateEvents(data: day).isEmpty {
                                                Text(event.title)
                                                    //.padding(.leading,10)
                                                    .padding(.bottom, 10)
                                                    .foregroundColor(.black)
                                                    
    
                                                
                                            }

                                        }
                                        Divider()
                                    }
                                    
                                }
                                
                                // percorre as tarefas do dia e as apresenta na tela
                                VStack(alignment: .leading) {
                                    // verifica se ha tarefas nessa data
                                    if !schedule.dateTasks(data: day).isEmpty {
                                    Text("Atividades")
                                        .padding(.top, 20)
                                        .font(.headline)
                                        .multilineTextAlignment(.leading)
                                        
                                    Section {
                                        //percorre as tarefas do dia
                                        ForEach(schedule.dateTasks(data: day), id: \.self) { index in
                                            let task = schedule.tasks[index]
                                                HStack {
                                                    // cada tarefa separada por um divisor abaixo do horario setado (formatado)
                                                    Spacer()
                                                    Text(schedule.tasks[index].formattedTime)
                                                        .padding(.trailing, 10)
                                                }
                                                Divider()
                                            NavigationLink(destination: TaskInfoView(originalTask: $schedule.tasks[index],
                                                                                     task: task)) {
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
                                                                if Calendar.current.isDate(currentDate, inSameDayAs: task.date),
                                                                   let adjustedStart = Calendar.current.date(byAdding: .minute, value: -5, to: task.startTime),
                                                                   currentDate >= adjustedStart && currentDate <= task.endTime {
                                                                    Image(systemName: "play.fill")
                                                                        .padding(.horizontal, 10)
                                                                        .padding(.vertical, 4)
                                                                        .background(Color("AccentColor"))
                                                                        .foregroundStyle(.white)
                                                                        .clipShape(Capsule())
                                                                } else {
                                                                    Image(systemName: "play.fill")
                                                                        .padding(.horizontal, 10)
                                                                        .padding(.vertical, 4)
                                                                        .hidden()
                                                                }


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
                                                    .background(task.isCompleted ? Color(.systemGray6) : .white)
                                                    .cornerRadius(8)
                                                    .grayscale(task.isCompleted ? 0.8 : 0.0)
                                                    .opacity(task.isCompleted ? 0.5 : 1.0)
                                                    .padding(.horizontal, 5)
                                                    .shadow(radius: 2)
                                            
                                            }
                                        }
                                    } else {
                                        if !schedule.dateEvents(data: day).isEmpty {
                                            Text("Atividades")
                                                .padding(.top, 10)
                                                .font(.headline)
                                                .multilineTextAlignment(.leading)
                                        }
                                        
                                        Divider()
                                            .padding(.top, 10)
                                        Text("Não há tarefas!")
                                            
                                            .foregroundColor(.secondary)
//                                        Divider()
//                                            .padding(.bottom, 20)
                                    }

                                }
                                Divider()
                                
                            }
                             //insere + na toolbar para ir para tela de AddTask
                            //.padding(.horizontal, 10)
                            NavigationLink.init("",
                                                destination: AddItemView(),
                                                isActive: $navigateToAddItem)
                                    }.navigationTitle("Minha Rotina").navigationBarTitleDisplayMode(.inline)
                                      .frame(maxWidth: .infinity, maxHeight: .infinity)
                                      .background(Color(.secondarySystemBackground))
                                      .toolbar {
                                        ToolbarItem(placement: .navigationBarTrailing) {
                                          Button(action: {
                                            navigateToAddItem = true
                                          }) {
                                            Text("+")
                                                  .foregroundColor(Color("AccentColor"))
                                              .font(.system(size: 30))
                                          }
                                        }
                                      }
                        }
                    }
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                    Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
                        currentDate = Date()
                    }
                }
                .padding(.horizontal, 10)
                .background(Color(.secondarySystemBackground))
                
                
                }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            //
            }
        //.background(Color(.secondarySystemBackground))
        }
    }

                            
//    struct PlannerView_Previews: PreviewProvider {
//        static var previews: some View {
//            PlannerView(week: Week.exampleWeek)
//        }
//    }
//}
