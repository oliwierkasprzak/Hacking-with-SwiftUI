//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Oliwier Kasprzak on 08/01/2023.
//

import SwiftUI

struct FlagImage: View {
    var imageName: String
  
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 10)
    }
    
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var numberOfQuestions = 0
    @State private var isGameOver = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var correctAnwser = Int.random(in: 0...2)
    
    
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
                
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing: 20) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnwser])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(imageName: countries[number])

                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            
            .padding()
        }
        
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                if scoreTitle == "Correct" {
                    Text("You got it! It was \(countries[correctAnwser]) ")
                } else {
                    Text("You got it wrong :( It was \(countries[correctAnwser]) ")
                }
                Text("Your score is \(score)")
                
            }
            
            .alert("GAME OVER", isPresented: $isGameOver) {
                Button("Play again?", action: endGame)
            } message: {
                Text("The game is over! Your final score is: \(score)")
            }
            
        }
    func endGame() {
       score = 0
       numberOfQuestions = 0
       isGameOver = false
       
    }
    func flagTapped(_ number: Int) {
        if number == correctAnwser {
            scoreTitle = "Correct"
            score += 1
            numberOfQuestions += 1
        } else {
            scoreTitle = "Wrong"
            score -= 1
            numberOfQuestions += 1
        }
        
        showingScore = true
        
        if numberOfQuestions == 8 {
            isGameOver = true
            showingScore = false
            countries.shuffle()
            correctAnwser = Int.random(in: 0...2)
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnwser = Int.random(in: 0...2)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
