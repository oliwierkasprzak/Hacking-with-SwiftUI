//
//  EditView.swift
//  BucketList
//
//  Created by Oliwier Kasprzak on 10/03/2023.
//

import SwiftUI

struct EditView: View {
    enum LoadingState {
        case loading, loaded, failed
    }

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                    
                    
                    
                    switch loadingState {
                    case .loading:
                        Text("Loading…")
                    case .loaded:
                        ForEach(pages, id: \.pageId) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }

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
            .task {
                await fetchNearbyPlaces()
            }
        }
    }

    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }

    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinates.latitude)%7C\(location.coordinates.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            pages = items.query.pages.values.sorted()
            loadingState = .loaded
        } catch {
            loadingState = .failed
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { _ in }
    }
}
