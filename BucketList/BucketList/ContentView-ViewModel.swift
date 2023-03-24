//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Oliwier Kasprzak on 12/03/2023.
//

import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
   @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published private(set) var locations: [Location]
        
        @Published var showingPlace: Location?
       
        let saveURL = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
       
        @Published var isUnlocked = false
       
        @Published var showingAuthenticationError = false
       
       init() {
           do {
               let data = try Data(contentsOf: saveURL)
               locations = try JSONDecoder().decode([Location].self, from: data)
           } catch {
               locations = []
           }
       }
       
       func addLocation() {
           let newLocation = Location(id: UUID(), name: "New location", description: "", longitude: mapRegion.center.longitude, latitude: mapRegion.center.latitude)
               locations.append(newLocation)
            save()
       }
       
       func update(location: Location) {
           guard let showingPlace = showingPlace else { return }
           
           if let index = locations.firstIndex(of: showingPlace) {
               locations[index] = location
               save()
           }
       }
       
       func save() {
           do {
               let data = try JSONEncoder().encode(locations)
               try data.write(to: saveURL, options: [.atomic, .completeFileProtection])
           } catch {
               print("Failed to save")
           }
       }
       
       func authenticate() {
           let context = LAContext()
           var error: NSError?
           
           if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
               let reason = "Please authorize to show your places."
               
               context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticateError in
                   if success {
                       Task { @MainActor in
                           self.isUnlocked = true
                       }
                   } else {
                       Task { @MainActor in
                           self.showingAuthenticationError = true
                       }
                       print("Failed to authenticate")
                   }
               }
           }
       }
    }
}
