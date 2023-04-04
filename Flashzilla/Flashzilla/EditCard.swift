//
//  EditCard.swift
//  Flashzilla
//
//  Created by Oliwier Kasprzak on 02/04/2023.
//

import SwiftUI

struct EditCard: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var prompt = ""
    @State private var answer = ""
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $prompt)
                    TextField("Answer", text: $answer)
                    Button("Add card", action: addCard)
                }
                
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .foregroundColor(.black)
                                .font(.title)
                            
                            Text(cards[index].answer)
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                        }
                    }
                    .onDelete(perform: removeCards)
                    
                } header: {
                    Text("Cards")
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear(perform: loadData)
        }
    }
    func done() {
        dismiss()
    }
    
    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        save()
    }
    
    func save() {
        let url = getDocumentsDirectory().appendingPathComponent("cards.json")
        if let data = try? JSONEncoder().encode(cards) {
            try? data.write(to: url, options: .atomic)
        }
    }
    
    func loadData() {
        let url = getDocumentsDirectory().appendingPathComponent("cards.json")
         let data = try? Data(contentsOf: url)
            if let decoded = try? JSONDecoder().decode([Card].self, from: data ?? Data([]) ) {
                cards = decoded
            }
        
    }
    
    func addCard() {
        let trimmedAnswer = answer.trimmingCharacters(in: .whitespaces)
        let trimmedPrompt = prompt.trimmingCharacters(in: .whitespaces)
        guard trimmedAnswer.isEmpty == false && trimmedPrompt.isEmpty == false else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        save()
        answer = ""
        prompt = ""
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory , in: .userDomainMask)
        return paths[0]
    }
}

struct EditCard_Previews: PreviewProvider {
    static var previews: some View {
        EditCard()
    }
}
