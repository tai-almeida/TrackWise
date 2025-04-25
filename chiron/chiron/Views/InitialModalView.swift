import SwiftUI

struct FullScreenModalView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                VStack(spacing: 20) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height * 1.0)
                .background(Color.white)
                .cornerRadius(20)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

struct ContentView: View {
    @State private var isPresented = false

    var body: some View {
        Button("Show") {
            isPresented.toggle()
        }
        .sheet(isPresented: $isPresented) {
            FullScreenModalView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
