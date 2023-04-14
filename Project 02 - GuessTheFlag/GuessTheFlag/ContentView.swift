//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Oliwier Kasprzak on 08/01/2023.
//

import SwiftUI

struct FlagImage: View {
    var imageName: String
    var rotateAmount: Double
    var opacityAmount: Double
    var scaleAmount: Double
    var countries: [String]
    var number: Int
  
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 10)
            .opacity(opacityAmount)
            .scaleEffect(scaleAmount)
            .rotation3DEffect(.degrees(Double(rotateAmount)),
                               axis: (x: 0.0, y: 1.0, z: 0.0))
            .accessibilityLabel(labels[countries[number], default: "Unknown label"])
    }
    
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var numberOfQuestions = 0
    @State private var isGameOver = false
    @State private var animationDetector = -1
    
    @State private var rotateAmount = 0.0
    @State private var opacityAmount = 1.0
    @State private var scaleAmount = 1.0
    
     static var allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var countries = allCountries.shuffled()
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
                            withAnimation {
                                rotateAmount += 360
                            }
                            
                            withAnimation {
                                opacityAmount -= 0.5
                                scaleAmount -= 0.5
                            }
                        }
                        
                        label: {
                            FlagImage(imageName: countries[number],
                                      rotateAmount: (animationDetector == number ? rotateAmount : 0.0),
                                      opacityAmount: (animationDetector == number ? 1.0 : opacityAmount),
                                      scaleAmount: (animationDetector == number ? 1.0 : scaleAmount),
                                      countries: countries,
                                      number: number)
                               

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
        countries = Self.allCountries
        askQuestion()
        isGameOver = false
       
    }
    func flagTapped(_ number: Int) {
        animationDetector = number
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
            correctAnwser = Int.random(in: 0...2)
        }
    }
    
    func askQuestion() {
        countries.remove(at: correctAnwser)
        correctAnwser = Int.random(in: 0...2)
        opacityAmount = 1
        scaleAmount = 1
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
