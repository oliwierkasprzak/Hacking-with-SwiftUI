//
//  ContentView.swift
//  Moonshoot
//
//  Created by Oliwier Kasprzak on 18/01/2023.
//

import SwiftUI

struct ContentView: View {
    let astronaut: [String: Austronaut] = Bundle.main.decode("astronauts.json")
    let mission: [Mission] = Bundle.main.decode("missions.json")
    
    let column = [
        GridItem(.adaptive(minimum: 150))
    ]
    @State private var isGrid = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                if isGrid {
                    LazyVGrid(columns: column) {
                        ForEach(mission) { mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronaut)
                            } label: {
                                VStack {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding()
                                    
                                    VStack {
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        
                                        Text(mission.formattedLaunchDate)
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.5))
                                    }
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .background(.darkBackround)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.darkBackround)
                                }
                            }
                        }
                    }
                    .padding([.horizontal, .bottom])
                } else {
                    VStack {
                        ForEach(mission) { mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronaut)
                            } label: {
                                VStack {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding()
                                    
                                    VStack {
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        
                                        Text(mission.formattedLaunchDate)
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.5))
                                    }
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .background(.darkBackround)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.darkBackround)
                                }
                            }
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                
            }
            .navigationTitle("Moonshot")
            .background(.lightBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Toggle(isOn: $isGrid) {
                        Text(isGrid ? "Grid" : "List")
                            .foregroundColor(.white)
                            
                            
                    }
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
