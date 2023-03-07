//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Oliwier Kasprzak on 10/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var showingScore = false
    @State private var computersChoice = Int.random(in: 0...2)
    @State private var isGameOver = false
    
    var possibilities = ["Rock", "Paper", "Scissors"]
    var beats = ["Paper", "Scissors", "Rock"]
    var systemSymbols = ["mountain.2", "paperplane", "scissors"]
    @State private var winLose = ["Win", "Lose"]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                        .init(color: Color(red: 1, green: 0.6, blue: 0.59), location: 0.6),
                        .init(color: Color(red: 0.1, green: 0.7, blue: 0.8), location: 0.8)
                        
                    ], center: .top, startRadius: 200, endRadius: 900)
                        .ignoresSafeArea()
                    VStack {
                        Spacer()
                        
                        Text("Rock Paper Scissors")
                            .font(.largeTitle.weight(.bold))
                            .foregroundColor(.white)
                        VStack(spacing: 20) {
                            VStack {
                                Text("Computer has chosen: \(possibilities[computersChoice])")
                                    .foregroundColor(.secondary)
                                    .font(.subheadline.weight(.heavy))
                                Text("Player has to: \(winLose[Int.random(in: 0...1)])")
                                    .font(.largeTitle.weight(.semibold))
                            }
                            
                            ForEach(0..<3) { number in
                                Button {
                                    buttonTapped(number)
                                } label: {
                                    Image(systemName: systemSymbols[number])
                                        .resizable()
                                        .frame(width: 140, height: 100)
                                        .tint(.cyan)
                                        

                                }
                            }
                        }
                        .frame(width: .infinity)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 20)
                        .background(.ultraThinMaterial)
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
                        Button("Continue", action: playAgain)
                    } message: {
                        if scoreTitle == "Correct" {
                           
                        } else {
                         
                        }
                        Text("Your score is \(score)")
                        
                    }
                    
                    .alert("GAME OVER", isPresented: $isGameOver) {
                        Button("Play again?", action: endGame)
                    } message: {
                        Text("The game is over! Your final score is: \(score)")
                    }
                    
                }
    
    
    func buttonTapped(_ number: Int) {
        
        
        showingScore = true
    }
    
    func playAgain() {
        
        computersChoice = Int.random(in: 0...2)
        
    }
    
    func endGame() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
