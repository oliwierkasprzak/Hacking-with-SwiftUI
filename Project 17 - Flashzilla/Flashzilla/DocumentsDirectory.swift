//
//  DocumentsDirectory.swift
//  Flashzilla
//
//  Created by Oliwier Kasprzak on 24/04/2023.
//

import Foundation

extension FileManager {
    static var getDocumentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
