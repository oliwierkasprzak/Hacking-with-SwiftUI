//
//  AddView.swift
//  iExpense
//
//  Created by Oliwier Kasprzak on 17/01/2023.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @ObservedObject var expensesPersonal: Expenses
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.mint, .cyan, .blue], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                Form {
                    TextField("Name", text: $name)
                    
                    Picker("Type", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                }
                .navigationTitle("Add new expense")
                .toolbar {
                    Button("Save") {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        if type == "Personal" {
                            expensesPersonal.items.append(item)
                        } else {
                            expenses.items.append(item)
                        }
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses(), expensesPersonal: Expenses())
    }
}
