//
//  AdressView.swift
//  CupcakeCorner
//
//  Created by Oliwier Kasprzak on 13/02/2023.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: OrderStorage

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street address", text: $order.address)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }

            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.isNotValid == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(order: OrderStorage())
        }
    }
}
