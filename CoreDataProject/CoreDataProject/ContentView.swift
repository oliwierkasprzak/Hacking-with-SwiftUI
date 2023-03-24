//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Oliwier Kasprzak on 25/02/2023.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    @State private var filterShowing = "T"
    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(country.wrappedFullName) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            
            Button("Add") {
                let candy1 = Candy(context: moc)
                candy1.name = "Mars"
                candy1.country = Country(context: moc)
                candy1.country?.fullName = "United Kingdom"
                candy1.country?.shortName = "UK"
                
                let candy2 = Candy(context: moc)
               candy2.name = "KitKat"
               candy2.country = Country(context: moc)
               candy2.country?.shortName = "UK"
               candy2.country?.fullName = "United Kingdom"

               let candy3 = Candy(context: moc)
               candy3.name = "Twix"
               candy3.country = Country(context: moc)
               candy3.country?.shortName = "UK"
               candy3.country?.fullName = "United Kingdom"

               let candy4 = Candy(context: moc)
               candy4.name = "Toblerone"
               candy4.country = Country(context: moc)
               candy4.country?.shortName = "CH"
               candy4.country?.fullName = "Switzerland"
                
                let candy5 = Candy(context: moc)
                candy5.name = "Reese's"
                candy5.country = Country(context: moc)
                candy5.country?.shortName = "US"
                candy5.country?.fullName = "United States of America"
                
                try? moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
