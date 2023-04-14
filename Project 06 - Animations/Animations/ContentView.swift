//
//  ContentView.swift
//  Animations
//
//  Created by Oliwier Kasprzak on 14/01/2023.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivor: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    let letters = Array("Hello, SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    @State private var animationScale = 0.0
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.mint)
                .frame(width: 200, height: 200)
            
            if enabled {
                Rectangle()
                    .fill(.black)
                    .frame(width: 200, height: 200)
                    .transition(.pivor)
            }
        }
        
        .onTapGesture {
            withAnimation {
                enabled.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
