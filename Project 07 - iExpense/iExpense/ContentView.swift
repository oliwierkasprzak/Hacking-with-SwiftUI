//
//  ContentView.swift
//  iExpense
//
//  Created by Oliwier Kasprzak on 17/01/2023.
//

import SwiftUI



struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpenses = false
    let localCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    var body: some View {
        NavigationView {
            ZStack {
                
                List {
                    ExpenseSection(title: "Business", expenses: expenses.business, deleteItems: removeBusinessItems)
                    ExpenseSection(title: "Personal", expenses: expenses.personal, deleteItems: removePersonalItems)
                }
                .navigationTitle("iExpense")
                .toolbar {
                    Button {
                        showingAddExpenses = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $showingAddExpenses) {
                    AddView(expenses: expenses, expensesPersonal: expenses)
                }
            }
        }
    }
    
   func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
       var objectsToDelete = IndexSet()

       for offset in offsets {
           let item = inputArray[offset]

           if let index = expenses.items.firstIndex(of: item) {
               objectsToDelete.insert(index)
           }
       }

       expenses.items.remove(atOffsets: objectsToDelete)
   }
    
    func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.personal)
    }

    func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.business)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
