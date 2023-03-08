//
//  ContentView.swift
//  BucketList
//
//  Created by Oliwier Kasprzak on 07/03/2023.
//

import MapKit
import SwiftUI
struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
struct ContentView: View {
    @State private var cordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.12, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.9, longitudeDelta: 0.9))
    
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    var body: some View {
        Map(coordinateRegion: $cordinateRegion, annotationItems: locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.red)
                    .onTapGesture {
                        print("hello")
                    }
            }
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
