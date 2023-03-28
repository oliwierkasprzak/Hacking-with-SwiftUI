//
//  Prospects.swift
//  HotProspects
//
//  Created by Oliwier Kasprzak on 28/03/2023.
//

import SwiftUI

class Prospect: Codable, Identifiable {
    var id = UUID()
    var name = "Oliwier Kasprzak"
    var emailAddress = ""
    var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        people = []
    }
}
