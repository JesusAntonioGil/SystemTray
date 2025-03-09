//
//  ContentView.swift
//  SystemTray
//
//  Created by Jesus Antonio Gil on 8/3/25.
//

import SwiftUI


enum CurrentView {
    case actions
    case periods
}


struct ContentView: View {
    @State private var show: Bool = false
    @State private var currentView: CurrentView = .actions
    
    
    var body: some View {
        Button("Show Trat View") {
            show.toggle()
        }
        .systemTrayView($show) {
            Text("Hello From Tray")
                .frame(maxWidth: .infinity)
                .frame(height: 300)
        }
    }
    
    
    @ViewBuilder
    private func View1() -> some View {
        VStack(spacing: 12) {
            HStack {
                Text("Choose description")
            }
        }
    }
}


#Preview {
    ContentView()
}
