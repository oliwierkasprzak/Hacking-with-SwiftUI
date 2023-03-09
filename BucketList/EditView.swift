//
//  EditView.swift
//  BucketList
//
//  Created by Oliwier Kasprzak on 09/03/2023.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var location: Location
    @State private var name = ""
    @State private var description = ""
    var onSave: (Location) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Edit places")
            .toolbar {
                Button("Save") {
                   var newLocation = location
                    newLocation.id = UUID()
                   newLocation.name = name
                   newLocation.description = description

                   onSave(newLocation)
                   dismiss()
                   
                }
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave

        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { _ in }
    }
}
