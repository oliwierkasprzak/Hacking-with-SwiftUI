//
//  DataManager.swift
//  Flashzilla
//
//  Created by Oliwier Kasprzak on 24/04/2023.
//

import Foundation

struct DataManager {
    static let dataURL = FileManager.getDocumentsDirectory.appendingPathComponent("savedData")
    
   static func loadData() -> [Card] {
        if let data = try? Data(contentsOf: dataURL) {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                return decoded
            }
        }
       return []
    }
    
    static func saveData(_ cards: [Card]) {
        if let encoded = try? JSONEncoder().encode(cards) {
            try? encoded.write(to: dataURL, options: [.atomic, .completeFileProtection])
        }
    }
}
