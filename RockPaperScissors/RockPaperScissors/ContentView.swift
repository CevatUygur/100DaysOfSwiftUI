//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by CEVAT UYGUR on 22.02.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var possibleMoves = ["Rock", "Paper", "Scissors"]
    @State private var winOrLose = Bool.random()
    @State private var score = 0
    @State private var randomMove = 0
    @State private var numberOfQuestions = 1
    @State private var gameOver = false
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        
        VStack {
            Spacer()
            Text("App's move: \(!gameOver ? possibleMoves[randomMove] : "Game Over")")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
            Spacer()
            Text("Player should: \(!gameOver ? (winOrLose ? "Win" : "Lose") : "Game Over")")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
                
            Spacer()
            
            VStack(spacing: 15) {
                
                ForEach(0..<3) { number in
                    Button {
                        ButtonTapped(number)
                    } label: {
                        Text(possibleMoves[number])
                            .clipShape(Capsule())
                            .shadow(radius: 5)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .foregroundColor(.primary)
                
            }
           
            Spacer()
            Text("Score: \(score)")
                .foregroundColor(.white)
                .font(.title.bold())
            
            Spacer()
            
            Text("\(gameOver ? "Game Over" : "")")
                .foregroundColor(.white)
                .font(.title.bold())
            
        }
        .padding()
    }
}
    
    func ButtonTapped (_ number: Int) {
        if possibleMoves[randomMove] == "Rock" && winOrLose {
            if possibleMoves[number] == "Paper" {
                correctAnswer()
            } else {
                wrongAnswer()
            }
        }
        
        if possibleMoves[randomMove] == "Rock" && !winOrLose {
            if possibleMoves[number] == "Scissors" {
                correctAnswer()
            } else {
                wrongAnswer()
            }
        }
        
        if possibleMoves[randomMove] == "Paper" && winOrLose {
            if possibleMoves[number] == "Scissors" {
                correctAnswer()
            } else {
                wrongAnswer()
            }
        }
        
        if possibleMoves[randomMove] == "Paper" && !winOrLose {
            if possibleMoves[number] == "Rock" {
                correctAnswer()
            } else {
                wrongAnswer()
            }
        }
        
        if possibleMoves[randomMove] == "Scissors" && winOrLose {
            if possibleMoves[number] == "Rock" {
                correctAnswer()
            } else {
                wrongAnswer()
            }
        }
        
        if possibleMoves[randomMove] == "Scissors" && !winOrLose {
            if possibleMoves[number] == "Paper" {
                correctAnswer()
            } else {
                wrongAnswer()
            }
        }
        
        askQuestion()
    }
    
    func askQuestion() {
        if numberOfQuestions == 10 {
            gameOver = true
        } else {
            winOrLose.toggle()
            possibleMoves.shuffle()
            randomMove = Int.random(in: 0...2)
            numberOfQuestions += 1
        }
        
    }
    
    func correctAnswer() {
        if !gameOver {
            score += 1
        }
        
    }
    
    func wrongAnswer() {
        if !gameOver {
            if score <= 0 {
                score = 0
            } else {
                score -= 1
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
