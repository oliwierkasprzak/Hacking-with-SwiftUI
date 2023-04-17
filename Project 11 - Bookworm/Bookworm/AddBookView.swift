//
//  AddBookView.swift
//  Bookworm
//
//  Created by Oliwier Kasprzak on 21/02/2023.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var review = ""
    @State private var rating = 3
    
    let types = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    @State private var saveValidation = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        let book = Book(context: moc)
                        book.id = UUID()
                        book.title = title
                        book.author = author
                        book.genre = genre
                        book.review = review
                        book.rating = Int16(rating)
                        book.date = Date.now
                        
                        
                        try? moc.save()
                        dismiss()
                        
                    }
                    
                }
                .disabled(title.isEmpty || author.isEmpty)
            }
            .navigationTitle("Add Book")
        }
                
    }
    
    func checkIfValid() -> Bool {
        if title.isEmpty || author.isEmpty {
            return true
        } else {
            return false
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
