//
//  ContentView.swift
//  BucketList
//
//  Created by Oliwier Kasprzak on 07/03/2023.
//

import SwiftUI
struct ContentView: View {
    
    var body: some View {
            Text("hi")
            .onTapGesture {
                let str = "asdsad"
                let url = getDocumentsDirectory().appendingPathExtension("message.txt")
                
                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
