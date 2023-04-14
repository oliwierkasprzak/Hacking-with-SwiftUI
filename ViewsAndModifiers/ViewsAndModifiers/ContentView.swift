//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Oliwier Kasprzak on 10/01/2023.
//

import SwiftUI

struct Title: ViewModifier {
    var titleText: String

    func body(content: Content) -> some View {
        VStack {
            content
            Text(titleText)
                .font(.largeTitle)
                .foregroundColor(.blue)
                .padding(5)
        }
    }
}


extension View {
    func bigTitle(name text: String) -> some View {
        modifier(Title(titleText: text))
    }
}
struct ContentView: View {
    var body: some View {
        Text("Hello world")
            .padding()
            .bigTitle(name: "siema")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
