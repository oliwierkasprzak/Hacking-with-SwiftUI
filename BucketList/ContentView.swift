//
//  ContentView.swift
//  BucketList
//
//  Created by Oliwier Kasprzak on 07/03/2023.
//

import MapKit
import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = ViewModel()
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                    MapAnnotation(coordinate: location.coordinates) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                                .onTapGesture {
                                    viewModel.showingPlace = location
                                }
                            
                            Text(location.name)
                                .fixedSize()
                        }
                    }
                }
                .ignoresSafeArea()
                
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            viewModel.addLocation()
                        } label: {
                            Image(systemName: "plus")
                                .padding()
                                .background(.black.opacity(0.75))
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .padding(.trailing)
                             
                        }
                        
                        
                    }
                }
            }
            .sheet(item: $viewModel.showingPlace) { place in
                EditView(location: place) { newLocation in
                    viewModel.update(location: newLocation)
                }
                
            }
            
        } else {
            Button("Unlock here") {
                viewModel.authenticate()
            }
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
            
        }
            
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
