//
//  ContentView.swift
//  HotProspects
//
//  Created by Oliwier Kasprzak on 24/03/2023.
//

import SwiftUI

@MainActor class User: ObservableObject {
    @Published var name = "The Weeknd"
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    var body: some View {
        Text(user.name)
    }
}

struct EditView: View {
    @EnvironmentObject var user: User
    var body: some View {
        TextField("Name", text: $user.name)
    }
}
struct ContentView: View {
    @StateObject var user = User()
    var body: some View {
        VStack {
            EditView()
            DisplayView()
        }
        .environmentObject(user)
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
