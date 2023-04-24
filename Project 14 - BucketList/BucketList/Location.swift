//
//  Location.swift
//  BucketList
//
//  Created by Oliwier Kasprzak on 09/03/2023.
//

import Foundation
import CoreLocation

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    let longitude: Double
    let latitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static var example = Location(id: UUID(), name: "Buckingham Palace", description: "Where King lives", longitude: 51.501, latitude: -0.141)
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
