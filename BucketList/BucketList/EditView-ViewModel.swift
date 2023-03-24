//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Oliwier Kasprzak on 12/03/2023.
//

import Foundation

extension EditView {
    class ViewModel: ObservableObject {
         @Published var location: Location
        

        @Published var name: String
        @Published var description: String

        @Published var loadingState = LoadingState.loading
        @Published var pages = [Pages]()
        
        init(location: Location, name: String, description: String, loadingState: LoadingState = LoadingState.loading, pages: [Pages] = [Pages]()) {
            self.location = location
            self.name = name
            self.description = description
            self.loadingState = loadingState
            self.pages = pages
        }

    }
}
