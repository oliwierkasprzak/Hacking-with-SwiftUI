//
//  ContentView.swift
//  BucketList
//
//  Created by Oliwier Kasprzak on 07/03/2023.
//

import SwiftUI
struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}
struct ContentView: View {
    
    let users = [
        User(firstName: "Oliwier", lastName: "Kasprzak"),
        User(firstName: "Maja", lastName: "Gugała"),
        User(firstName: "Filip", lastName: "Michałczyk")
    ].sorted()
    
    var body: some View {
        List(users) { user in
            Text("\(user.firstName) \(user.lastName)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
