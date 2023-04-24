//
//  EditCard.swift
//  Flashzilla
//
//  Created by Oliwier Kasprzak on 02/04/2023.
//

import SwiftUI

struct EditCard: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = DataManager.loadData()
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
                    ForEach(cards) { card in
                        let index = cards.firstIndex(of: card)!
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
            
        }
    }
    func done() {
        dismiss()
    }
    
    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        DataManager.saveData(cards)
    }
    
   func addCard() {
        let trimmedAnswer = answer.trimmingCharacters(in: .whitespaces)
        let trimmedPrompt = prompt.trimmingCharacters(in: .whitespaces)
        guard trimmedAnswer.isEmpty == false && trimmedPrompt.isEmpty == false else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        DataManager.saveData(cards)
        answer = ""
        prompt = ""
    }
    
   
}


