//
//  ContentView.swift
//  ChallengeDay_2
//
//  ---> Game Rock, Paper, Scissors <---
//
//  Created by Mateusz Ratajczak on 30/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var score = 0
    @State private var rounds = 0
    @State private var shouldWin = Bool.random()
    @State private var gameOver = false
    @State private var appAnswer = Int.random(in: 0...2)
    @State private var userAnswer = 0
    
    let moves = ["Rock", "Paper", "Scissors"]
    let movesIcon = ["🪨", "🧻", "✂️"]
    
    func newMatch() {
        let oldAppAnswer = appAnswer
        while oldAppAnswer == appAnswer {
            appAnswer = Int.random(in: 0...2)
        }
        shouldWin.toggle()
    }
    
    func resetGame() {
        score = 0
        rounds = 0
        shouldWin = Bool.random()
        gameOver = false
        appAnswer = 0
        userAnswer = 0
    }
    
    func moveMade() {
        // when player win
        if moves[appAnswer] == "Rock" && moves[userAnswer] == "Paper" {
            score += shouldWin ? 1 : -1
        } else if moves[appAnswer] == "Paper" && moves[userAnswer] == "Scissors" {
            score += shouldWin ? 1 : -1
        } else if moves[appAnswer] == "Scissors" && moves[userAnswer] == "Rock" {
            score += shouldWin ? 1 : -1
            
        // when player lose
        } else if moves[appAnswer] == "Rock" && moves[userAnswer] == "Scissors" {
            score += shouldWin ? -1 : 1
        } else if moves[appAnswer] == "Paper" && moves[userAnswer] == "Rock" {
            score += shouldWin ? -1 : 1
        } else if moves[appAnswer] == "Scissors" && moves[userAnswer] == "Paper" {
            score += shouldWin ? -1 : 1
            
        // when player draw
        } else {
            score += 0
        }
        
        // score cannot be less than 0
        score = score < 0 ? 0 : score
        rounds += 1
        
        if rounds == 10 {
            gameOver = true
        } else {
            newMatch()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.mint, .white, .black], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    HStack(spacing: 30) {
                        Text("Score: \(score)")
                            .font(.largeTitle.bold())
                        Text("Round: \(rounds)")
                            .font(.largeTitle.bold())
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 15) {
                        HStack(spacing: 5) {
                            Text("\(shouldWin ? "Win" : "Lose")")
                                .foregroundColor(shouldWin ? .green : .red)
                                .font(.subheadline.weight(.heavy))
                            
                            Text("Against \(moves[appAnswer])")
                        }
                        
                        Text(movesIcon[appAnswer])
                            .font(.system(size: 80))
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 40) {
                        ForEach(0..<3) { move in
                            Button {
                                userAnswer = move
                                moveMade()
                            } label: {
                                Text(movesIcon[move])
                                    .font(.system(size: 80))
                            }
                        }
                    }
                    Spacer()
                }
            }
            .navigationTitle("Rock Paper Scissors")
            .alert("Game Over", isPresented: $gameOver) {
                Button("Reset Game", role: .destructive, action: resetGame)
            } message: {
                Text("Your final score is \(score)/10")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
