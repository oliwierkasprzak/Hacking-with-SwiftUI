//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Oliwier Kasprzak on 25/02/2023.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var country: Country?
    
    public var wrappedName: String {
        name ?? "Unknown name"
    }

}

extension Candy : Identifiable {

}
