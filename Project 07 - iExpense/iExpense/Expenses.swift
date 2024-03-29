//
//  Expenses.swift
//  iExpense
//
//  Created by Oliwier Kasprzak on 17/01/2023.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    var personal: [ExpenseItem] {
        items.filter { $0.type == "Personal"}
    }
    
    var business: [ExpenseItem] {
        items.filter { $0.type == "Businnes"}
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
