//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Oliwier Kasprzak on 04/04/2023.
//

import SwiftUI



struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        let scale = 1 - max((geo.frame(in: .global).minY - 200) / fullView.size.height, 0) * 0.5
                        let hue = Double(geo.frame(in: .global).minY / fullView.size.height)
                        let color = Color(hue: hue, saturation: 1, brightness: 1)
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(color)
                            .opacity(max(1 + Double((geo.frame(in: .global).minY - 350) / 290), 0))
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2 + scrollOffset) / 5, axis: (x: 0, y: 1, z: 0))
                            .scaleEffect(scale)
                        
                    }
                    .frame(height: 40)
                }
            }
            .onPreferenceChange(OffsetPreferenceKey.self) { preferences in
                self.scrollOffset = preferences.y
            }
        }
    }
}

struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}

extension View {
    func offsetPreference() -> some View {
        return self.background(
            GeometryReader { proxy in
                Color.clear.preference(
                    key: OffsetPreferenceKey.self,
                    value: proxy.frame(in: .global).origin
                )
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
