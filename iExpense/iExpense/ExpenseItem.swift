//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Oliwier Kasprzak on 17/01/2023.
//

import Foundation

struct ExpenseItem: Equatable, Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
