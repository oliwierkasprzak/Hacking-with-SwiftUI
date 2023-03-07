//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Oliwier Kasprzak on 19/02/2023.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: OrderStorage
    
    @State private var confirmationMessage = ""
    @State private var confirmationTitle = ""
    @State private var showingMessage = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                
                Text("Your order is \(order.order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place order") {
                    Task {
                        await loadData()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .alert(confirmationTitle, isPresented: $showingMessage) {
            Button("OK") { }
        } message: {
             Text(confirmationMessage)
        }
    }
    
    func loadData() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode data")
            return
        }
        
            let url = URL(string: "https://reqres.in/api/cupcakes")!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
       
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedData = try JSONDecoder().decode(Order.self, from: encoded)
            confirmationMessage = "Your order for \(decodedData.quantity)x of \(Order.types[decodedData.type].lowercased()) is on its way!"
            confirmationTitle = "Thank you!"
            showingMessage = true
        } catch {
            showingMessage = true
            confirmationTitle = "Ops!"
            confirmationMessage = "Connection failed"
        }
    }
  
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: OrderStorage())
    }
}
