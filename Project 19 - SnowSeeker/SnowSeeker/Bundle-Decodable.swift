//
//  Bundle-Decodable.swift
//  SnowSeeker
//
//  Created by Oliwier Kasprzak on 11/04/2023.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate the file")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("No data found")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Couldn't load data")
        }
        
        return loaded
    }
}
