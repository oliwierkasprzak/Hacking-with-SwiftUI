//
//  Order.swift
//  CupcakeCorner
//
//  Created by Oliwier Kasprzak on 13/02/2023.
//

import SwiftUI

struct Order: Codable {
//    enum CodingKeys: CodingKey {
//        case type, quantity, addSprinkles, extraFrosting, name, address, city, zip
//    }
    static let types = ["Vanilla", "Chocolate", "Strawberry", "Rainbow"]
    
     var type = 0
     var quantity = 3
    
     var extraOptions = false {
        didSet {
            if extraOptions == false {
                addSprinkles = false
                extraFrosting = false
            }
        }
    }
     var addSprinkles = false
     var extraFrosting = false
    
     var name = ""
     var address = ""
     var city = ""
     var zip = ""
    
    var isNotValid: Bool {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        let trimmedCity = city.trimmingCharacters(in: .whitespaces)
        let trimmedAddress = address.trimmingCharacters(in: .whitespaces)
        let trimmedZip = zip.trimmingCharacters(in: .whitespaces)
        
        if trimmedName.isEmpty || trimmedAddress.isEmpty || trimmedCity.isEmpty || trimmedZip.isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        //base price is 2$
        var cost  = Double(quantity) * 2
        
        //different types cost more
        cost += Double(type) / 2
        
        //adding +1$ if extra frosting
        if extraFrosting {
            cost += 1
        }
        //and similar with sprinkled
        
        if addSprinkles {
            cost += 0.5
        }
        
        return cost
    }
    
//    init() { }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(type, forKey: .type)
//        try container.encode(quantity, forKey: .quantity)
//        try container.encode(addSprinkles, forKey: .addSprinkles)
//        try container.encode(extraFrosting, forKey: .extraFrosting)
//        try container.encode(name, forKey: .name)
//        try container.encode(address, forKey: .address)
//        try container.encode(city, forKey: .city)
//        try container.encode(zip, forKey: .zip)
//    }
//
//     init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        type = try container.decode(Int.self, forKey: .type)
//        quantity = try container.decode(Int.self, forKey: .quantity)
//        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//        name = try container.decode(String.self, forKey: .name)
//        address = try container.decode(String.self, forKey: .address)
//        city = try container.decode(String.self, forKey: .city)
//        zip = try container.decode(String.self, forKey: .zip)
//    }
}


class OrderStorage: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case order
    }
    @Published var order = Order()
    
    init() { }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        order = try container.decode(Order.self, forKey: .order)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(order, forKey: .order)
    }
    
    
}
