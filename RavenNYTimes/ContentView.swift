//
//  ContentView.swift
//  RavenNYTimes
//
//  Created by Isaí Abraham Innova on 16/04/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    Image(systemName: "newspaper.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    
                    Text("Raven NY Times")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Proyecto listo para comenzar")
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Inicio")
        }
    }
}

#Preview {
    ContentView()
}
