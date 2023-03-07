//
//  ContentView.swift
//  BetterRest
//
//  Created by Oliwier Kasprzak on 11/01/2023.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var idealBedTime = 0.0
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Form {
                    
                    Section {
                        Text("What time do you want to wake up?")
                            .font(.headline)
                        
                        DatePicker("Please select the time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    Section {
                        Text("Desired amoount of sleep")
                            .font(.headline)
                        
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                    Section {
                        Picker("Dailt coffee intake", selection: $coffeeAmount) {
                            ForEach(0..<20) { number in
                                Text(number == 1 ? "1 cup" : "\(number) cups")
                            }
                        }
                        .font(.headline)
                        
                    }
                    Section(header: Text("Recommended bedtime")) {
                        Text("\(calculateBedtime())")
                                            .font(.title)
                                    }
                }
            }
        
            
            
            .navigationTitle("BetterRest")
            
            
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
            
        }
        
        
    }
    
    
    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.minute, .hour], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let bedTime = sleepTime.formatted(date: .omitted, time: .shortened)
            
            return bedTime
            
        } catch {
            alertTitle = "Error!"
            alertMessage = "Something went wrong"
        }
        
        showingAlert = true
        
        return ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
