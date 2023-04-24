//
//  Prospects.swift
//  HotProspects
//
//  Created by Oliwier Kasprzak on 28/03/2023.
//

import SwiftUI

class Prospect: Codable, Comparable, Identifiable {
   
    var id = UUID()
    var name = "Oliwier Kasprzak"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    
    static func < (lhs: Prospect, rhs: Prospect) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func == (lhs: Prospect, rhs: Prospect) -> Bool {
        return lhs.name == rhs.name
    }
}

@MainActor class Prospects: ObservableObject {
    @Published fileprivate(set) var people: [Prospect]
    let saveKey = "people.json"
   
    init() {
        do {
            let url = Self.getDocumentsDirectory().appendingPathComponent(saveKey)
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Prospect].self, from: data)
            people = decoded
        } catch {
            people = []
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    private func save() {
        let url = Self.getDocumentsDirectory().appendingPathComponent(saveKey)
        
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: url, options: .atomic)
        } catch {
            print("Failed to save!")
        }
    }
    
    func toggleContacted(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
     static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
