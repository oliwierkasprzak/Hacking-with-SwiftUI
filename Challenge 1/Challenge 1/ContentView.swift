//
//  ContentView.swift
//  Challenge 1
//
//  Created by Oliwier Kasprzak on 08/01/2023.
//

import SwiftUI



struct ContentView: View {
    
    @State private var numberOf = 2.0
    @State private var chosenTimeBefore = "Minutes"
    @State private var chosenTimeAfter = "Seconds"
    @State private var afterConversion = 120.0
    
    private var conversion: Double {
        if chosenTimeBefore == "Seconds" && chosenTimeAfter == "Seconds" {
            return numberOf
        } else if  chosenTimeBefore == "Seconds" && chosenTimeAfter == "Minutes"{
            return numberOf / 60
        } else if  chosenTimeBefore == "Seconds" && chosenTimeAfter == "Hours"{
            return numberOf / (60 * 60)
        } else if  chosenTimeBefore == "Minutes" && chosenTimeAfter == "Minutes"{
            return numberOf
        } else if  chosenTimeBefore == "Minutes" && chosenTimeAfter == "Seconds"{
            return numberOf * 60
        } else if  chosenTimeBefore == "Minutes" && chosenTimeAfter == "Hours"{
            return numberOf / 60
        } else if  chosenTimeBefore == "Minutes" && chosenTimeAfter == "Days"{
            return numberOf / (60 * 24)
        } else if  chosenTimeBefore == "Hours" && chosenTimeAfter == "Seconds"{
            return numberOf * 60 * 60
        } else if  chosenTimeBefore == "Hours" && chosenTimeAfter == "Minutes"{
            return numberOf * 60
        } else if  chosenTimeBefore == "Hours" && chosenTimeAfter == "Hours"{
            return numberOf
        } else if  chosenTimeBefore == "Hours" && chosenTimeAfter == "Days"{
            return numberOf / 24
        } else if  chosenTimeBefore == "Days" && chosenTimeAfter == "Seconds"{
            return numberOf * 24 * 60 * 60
        } else if  chosenTimeBefore == "Days" && chosenTimeAfter == "Minutes"{
            return numberOf * 24 * 60
        } else if  chosenTimeBefore == "Days" && chosenTimeAfter == "Hours"{
            return numberOf * 24
        } else if  chosenTimeBefore == "Days" && chosenTimeAfter == "Days"{
            return numberOf
        } else {
            return numberOf / (60 * 60 * 24)
        }
    }
    
    let timeChoices = ["Seconds", "Minutes", "Hours", "Days"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input number", value: $numberOf, format: .number)
                    Picker("Conversion of", selection: $chosenTimeBefore) {
                        ForEach(timeChoices, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Picker("Conversion of", selection: $chosenTimeAfter) {
                        ForEach(timeChoices, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    
                } header: {
                    Text("Convert INTO")
                }
                
                Section {
                    Text("\(conversion)")
                } header: {
                    Text("Value after conversion")
                }
            }
            .navigationTitle("Time Units Converter")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
