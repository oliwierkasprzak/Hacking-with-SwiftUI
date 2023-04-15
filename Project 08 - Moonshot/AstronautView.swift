//
//  AstronautView.swift
//  Moonshoot
//
//  Created by Oliwier Kasprzak on 19/01/2023.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Austronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
            .background(.darkBackround)
            .navigationTitle(astronaut.name)
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [String: Austronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts["armstrong"]!)
    }
}
