//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Oliwier Kasprzak on 04/04/2023.
//

import SwiftUI

extension VerticalAlignment {
    struct MidAccountName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }
    static let midAccountName = VerticalAlignment(MidAccountName.self)
}

struct ContentView: View {
    var body: some View {
        HStack(alignment: .midAccountName) {
            VStack {
                Text("@lamedevswift")
                    .alignmentGuide(.midAccountName) { d in
                        d[VerticalAlignment.center]
                    }
                Image("f1")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            
            VStack {
                Text("Full name:")
                Text("Oliwier Kasprzak")
                    .font(.largeTitle)
                    .alignmentGuide(.midAccountName) { d in
                        d[VerticalAlignment.center]
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
