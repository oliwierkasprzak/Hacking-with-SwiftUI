//
//  ContentView.swift
//  HotProspects
//
//  Created by Oliwier Kasprzak on 24/03/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, github!")
                .padding()
            
            Text("Testing before tomorrow")
                .padding()
                .ignoresSafeArea()
                .background(.red)
            
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}