//
//  IniciarTask.swift
//  chiron
//
//  Created by Aluno 33 on 16/04/25.
//

import SwiftUI

struct IniciarTaskView: View {
    var body: some View {
        TaskNow(task: Task.exampleTask)
    }
}

struct IniciarTask_Previews: PreviewProvider {
    static var previews: some View {
        IniciarTaskView()
    }
}
