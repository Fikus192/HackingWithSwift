//
//  ContentView.swift
//  ChallengeDay_3
//
//  ---> Edutainment Game <---
//
//  Created by Mateusz Ratajczak on 11/04/2023.
//

import SwiftUI

struct CustomButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 1, green: 0.8392, blue: 0.6667))
            .foregroundColor(.black)
            .clipShape(Circle())
    }
}

class ViewModel: ObservableObject {
  
  @Published var multiplier = 2
  @Published var guessNumber = 0
  @Published var questionNumber = 5
  @Published var score = 0
  @Published var showingScore = false
  @Published var gameOver = false
  @Published var scoreTitle = ""
  @Published var randomAnswers = [Int]()
  
  let questionNumbers = [5, 10, 15, 20]
  @Published var correctAnswer = 0
  @Published var randomNumber = Int.random(in: 1...12)
  
  func newMatch() {
      let oldMultiplier = multiplier
      let oldRandomNumber = randomNumber
      while oldMultiplier == multiplier && oldRandomNumber == randomNumber {
          multiplier = multiplier
          randomNumber = Int.random(in: 1...12)
      }
    
    answer()
  }

  func resetGame() {
      score = 0
      guessNumber = 0
      questionNumber = 5
      showingScore = false
      gameOver = false
      multiplier = multiplier
      randomNumber = Int.random(in: 1...12)
      scoreTitle = ""
  }

  func answer() {
      correctAnswer = multiplier * randomNumber
      randomAnswers.append(correctAnswer)
      while randomAnswers.count != 3 {
          let randomNum = Int.random(in: 0...144)
          if !randomAnswers.contains(randomNum) && randomNum != correctAnswer {
            randomAnswers.append(randomNum)
          }
      }
    
    randomAnswers.shuffle()
  }

  func newCalculate(_ number: Int) {
      if number == correctAnswer {
          scoreTitle = "Correct!"
          score += 1
          guessNumber += 1
          randomAnswers.removeAll()
          showingScore = true
      } else {
          scoreTitle = "Wrong, Correct answer is \(multiplier * randomNumber)"
          guessNumber += 1
          randomAnswers.removeAll()
          showingScore = true
      }
    
      if guessNumber == questionNumber {
        scoreTitle = "End of Game"
        gameOver = true
      }
  }
}

struct ContentView: View {
  
  @StateObject var viewModel = ViewModel()
  
  // Proposal linear gradient custom
  @State var start = UnitPoint(x: 0, y: -2)
  @State var end = UnitPoint(x: 4, y: 0)
  let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
  let colors = [Color(.yellow), Color(.systemPink), Color(.cyan), Color(.purple), Color(.systemMint)]
  
  var body: some View {
    NavigationView {
      ZStack {
        LinearGradient(colors: colors, startPoint: start, endPoint: end)
          .ignoresSafeArea()
          .animation(Animation.easeInOut(duration: 10).repeatForever(autoreverses: true).speed(0.5))
          .onReceive(timer, perform: {_ in
            self.start = UnitPoint(x: 4, y: 0)
            self.end = UnitPoint(x: 0, y: 2)
            self.start = UnitPoint(x: -4, y: 20)
            self.start = UnitPoint(x: 4, y: 0)
          })
        
        VStack(spacing: 20) {
          Section {
            Stepper("\(viewModel.multiplier)", value: $viewModel.multiplier, in: 2...12)
          } header: {
            Text("Choose multiplication table to practice")
              .font(.headline)
              .foregroundColor(.white)
          }
          
          Section {
            Picker("How many question do you want?", selection: $viewModel.questionNumber) {
              ForEach(viewModel.questionNumbers, id: \.self) {
                Text("\($0)")
              }
            }
            .pickerStyle(.segmented)
          } header: {
            Text("How many questions do you want?")
              .font(.headline)
              .foregroundColor(.white)
          }
          
          
          Section {
            Text("What is \(viewModel.multiplier) * \(viewModel.randomNumber)?")
              .frame(width: 300, height: 50)
              .font(.headline)
              .foregroundColor(.white)
              .background(.secondary)
              .clipShape(RoundedRectangle(cornerRadius: 20))
          }
          
          HStack(spacing: 20) {
            ForEach(viewModel.randomAnswers, id: \.self) { number in
              Button {
                viewModel.newCalculate(number)
              } label: {
                Text("\(number)")
                  .font(.system(size: 40))
              }
              .buttonStyle(CustomButton())
            }
          }
          
          Section {
            Text("Score \(viewModel.score)/\(viewModel.questionNumber)")
              .frame(alignment: .center)
              .foregroundColor(.white)
              .font(.title.bold())
          }
          .padding(100)
        }
      }
      .navigationTitle("Edutainment")
      .onAppear {
        viewModel.answer()
      }
      
      .alert(viewModel.scoreTitle, isPresented: $viewModel.showingScore) {
        Button("Continue", action: viewModel.newMatch)
      } message: {
        Text("Your score is: \(viewModel.score)")
      }
      
      .alert(viewModel.scoreTitle, isPresented: $viewModel.gameOver) {
        Button("Reset Game", role: .destructive, action: {
            viewModel.resetGame()
            viewModel.newMatch()
          }
        )
      } message: {
        Text("Your final score is \(viewModel.score)/\(viewModel.questionNumber)")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
