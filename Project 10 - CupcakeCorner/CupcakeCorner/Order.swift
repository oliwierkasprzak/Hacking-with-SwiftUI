//
//  Order.swift
//  CupcakeCorner
//
//  Created by Oliwier Kasprzak on 13/02/2023.
//

import SwiftUI
@dynamicMemberLookup

class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    @Published var data = Order()

    subscript<T>(dynamicMember keyPath: KeyPath<Order, T>) -> T {
        data[keyPath: keyPath]
    }

    subscript<T>(dynamicMember keyPath: WritableKeyPath<Order, T>) -> T {
        get {
            data[keyPath: keyPath]
        }

        set {
            data[keyPath: keyPath] = newValue
        }
    }
}

struct MainOrder: Codable {
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }

    var extraFrosting = false
    var addSprinkles = false

    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""

    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }

        return true
    }

    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}
