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
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.mint, .cyan, .blue], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                List {
                    ForEach(expenses.items) { item in
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                           if item.amount < 10.0 {
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundColor(.red)
                            } else if item.amount < 100.0 {
                                 Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                     .foregroundColor(.green)
                             } else if item.amount > 100.0 {
                                 Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                     .foregroundColor(.yellow)
                                     
                                     
                             }
                        }
                    }
                    .onDelete(perform: removeItems)
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
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
