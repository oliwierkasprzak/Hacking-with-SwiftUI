//
//  ContentView.swift
//  HotProspects
//
//  Created by Oliwier Kasprzak on 26/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var output = ""
    var body: some View {
        Text(output)
            .task {
                await fetchLoading()
        }
    }
    
    func fetchLoading() async {
        let fetchTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let fetchedData = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(fetchedData.count) readings"
        }
        
        let results = await fetchTask.result
        
        switch results {
        case .success(let success):
            output = success
        case .failure(let failure):
            output = failure.localizedDescription
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
