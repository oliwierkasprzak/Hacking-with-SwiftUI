//
//  Results.swift
//  BucketList
//
//  Created by Oliwier Kasprzak on 10/03/2023.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Pages]
}

struct Pages: Codable, Comparable {
    let pageId: Int
    let title: String
    let terms: [String: [String]]?
    
    static func <(lhs: Pages, rhs: Pages) -> Bool {
        lhs.title < rhs.title
    }
    
    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
    
}
