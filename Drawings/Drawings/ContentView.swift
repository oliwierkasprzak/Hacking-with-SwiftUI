//
//  ContentView.swift
//  Drawings
//
//  Created by Oliwier Kasprzak on 20/01/2023.
//

import SwiftUI

struct Arrow: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 200, y: 250))
        path.addLine(to: CGPoint(x: 200, y: 540))
        path.move(to: CGPoint(x: 140, y: 250))
        path.addLine(to: CGPoint(x: 250, y: 250))
        path.addLine(to: CGPoint(x: 190, y: 150))
        path.addLine(to: CGPoint(x: 140, y: 250))

        
        return path
    }
    
}

struct ColorCyclingRectangle: View {
    var startColor: Color
    var endColor: Color
    var currentTime: Double
    var duration: Double
    var rect: CGRect
    var gradientX: CGFloat
    var gradientY: CGFloat

    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(
                    gradient: Gradient(colors: [startColor, endColor]),
                    startPoint: UnitPoint(x: gradientX, y: gradientX),
                    endPoint: UnitPoint(x: gradientY, y: gradientY)
                ))
                .frame(width: rect.width, height: rect.height)
                .offset(x: rect.minX, y: rect.minY)
                .animation(Animation.linear(duration: duration).repeatForever(autoreverses: false))
                .rotationEffect(.degrees(360 * (currentTime / duration)))
        }
    }
}


struct ContentView: View {
    @State private var amount = 0.0
    @State private var gradientYX = 0.1
    @State private var gradientXY = 0.2
    var body: some View {
//        VStack {
//            Arrow()
//                .stroke(.red, lineWidth: amount)
//
//            Button("Change thickness") {
//              var randomAmount = Int.random(in: 1...20)
//                withAnimation {
//                    amount = Double(randomAmount)
//                }
//            }
//        }
        VStack {
            ColorCyclingRectangle(startColor: .mint, endColor: .red, currentTime: 0, duration: 1, rect: CGRect(x: 10, y: 10, width: 100, height: 100), gradientX: gradientXY, gradientY: gradientYX)
            
            
            Slider(value: $gradientYX)
                .padding()
            Slider(value: $gradientXY)
                .padding()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
