//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Oliwier Kasprzak on 06/02/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = OrderStorage()
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("What type of cake?", selection: $order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                            
                            
                        }
                    }
                    Stepper("How many cakes: \(order.quantity)", value: $order.quantity)
                }
                
                Section {
                    Toggle("Do you want some extra options?", isOn: $order.extraOptions.animation())
                    
                    if order.extraOptions {
                        Toggle("Maybe some sprinkles?", isOn: $order.addSprinkles)
                        Toggle("Or some extra frosting?", isOn: $order.extraFrosting)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
                
            }
            .listStyle(InsetListStyle())
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
