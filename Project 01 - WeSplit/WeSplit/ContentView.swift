//
//  ContentView.swift
//  WeSplit
//
//  Created by Oliwier Kasprzak on 07/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocues: Bool
    
    
    var totalPerPerson: Double {
        
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTolal = checkAmount + tipValue
        let amountPerPerson = grandTolal / peopleCount
        
        return amountPerPerson
    }
    
    var totalCheck: Double {
        
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let checkValue = checkAmount + tipValue
        return checkValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format:
                        .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocues)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("HOW MUCH TIP DO TOU WANT TO LEAVE?")
                }
                
                Section {
                    Text(totalPerPerson, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("AMOUNT PER PERSON")
                }
                
                Section {
                    Text(totalCheck, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("FINAL AMOUNT WITH TIP")
                }
            }
            
          
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocues = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
