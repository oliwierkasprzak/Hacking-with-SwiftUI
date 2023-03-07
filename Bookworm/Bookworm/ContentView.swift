//
//  ContentView.swift
//  Bookworm
//
//  Created by Oliwier Kasprzak on 20/02/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    
   
    
    @State private var showingAddNewBook = false
    
 
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(books) { book in
                        NavigationLink {
                            DetailView(book: book)
                        } label: {
                            HStack {
                                if book.rating == 1 {
                                    EmojiRatingView(rating: book.rating)
                                        .font(.largeTitle)
                                    
                                    VStack(alignment: .leading) {
                                        Text(book.title ?? "Unknown title")
                                            .font(.headline)
                                            .foregroundColor(.red)
                                        
                                        Text(book.author ?? "Unknown author")
                                            .foregroundColor(.red)
                                        Text(book.date.map { date in
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.dateFormat = "yy-MM-dd"
                                            return LocalizedStringKey(dateFormatter.string(from: date))
                                        } ?? "Unknown date")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    }
                                } else {
                                    EmojiRatingView(rating: book.rating)
                                        .font(.largeTitle)
                                    
                                    VStack(alignment: .leading) {
                                        Text(book.title ?? "Unknown title")
                                            .font(.headline)
                                        Text(book.author ?? "Unknown author")
                                            .foregroundColor(.secondary)
                                        Text(book.date.map { date in
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.dateFormat = "yy-MM-dd"
                                            return LocalizedStringKey(dateFormatter.string(from: date))
                                        } ?? "Unknown date")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                    }
                
                    
                    .onDelete(perform: deleteBook)
                }
                    .navigationTitle("Bookworm")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            EditButton()
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                showingAddNewBook.toggle()
                            } label: {
                                Label("Add Book", systemImage: "plus")
                            }
                        }
                    }
                    .sheet(isPresented: $showingAddNewBook) {
                        AddBookView()
                    }
            }
        }
    }
    
    func deleteBook(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
