//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by CEVAT UYGUR on 21.02.2022
//

import SwiftUI

//Create a custom view
struct FlagImage: View {
    var countryFlags: String
    
    var body: some View {
        Image(countryFlags)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var gameOver = false
    @State private var numberOfQuestions = 0
   
    // Properties for animating the chosen flag
    @State private var animateCorrect = 0.0
    @State private var animateOpacity = 1.0
    @State private var besidesTheCorrect = false
    @State private var besidesTheWrong = false
    @State private var selectedFlag = 0
    
   
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 500, endRadius: 900)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag off")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button(action: {
                            self.flagTapped(number)
                            self.selectedFlag = number
                        }) {
                            FlagImage(countryFlags: self.countries[number])
                        }
                        // Animate the flag when the user tap the correct one:
                        // Rotate the correct flag
                        .rotation3DEffect(.degrees(number == self.correctAnswer ? self.animateCorrect : 0), axis: (x: 0, y: 1, z: 0))
                        // Reduce opacity of the other flags to 25%
                        .opacity(number != self.correctAnswer && self.besidesTheCorrect ? self.animateOpacity : 1)
                        
                        // Animate the flag when the user tap the wrong one:
                        // Create a red background to the wrong flag
                        .background(self.besidesTheWrong && self.selectedFlag == number ? Capsule(style: .circular).fill(Color.red).blur(radius: 30) : Capsule(style: .circular).fill(Color.clear).blur(radius: 0))
                        // Reduce opacity of the other flags to 25% (including the correct one)
                        .opacity(self.besidesTheWrong && self.selectedFlag != number ? self.animateOpacity : 1)
            
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
            
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        
        .alert(scoreTitle, isPresented: $gameOver) {
            Button("Restart the game", action: restartGame)
        } message: {
            Text("Game over. Your score is \(score)")
        }
    }
    
    func flagTapped (_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            
            //Create animation for the correct answer
            withAnimation {
                self.animateCorrect += 360
                self.animateOpacity = 0.25
                self.besidesTheCorrect = true
            }
            
        } else {
            scoreTitle = "Wrong, That's the flag of \(countries[number])"
            
            //Create animation for the wrong answer
            withAnimation {
                self.animateOpacity = 0.25
                self.besidesTheWrong = true
            }
        }
        showingScore = true
        
        if numberOfQuestions == 8 {
            showingScore = false
            gameOver = true
            
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        numberOfQuestions += 1
        
        //Return the booleans false
        besidesTheCorrect = false
        besidesTheWrong = false
    }
    
    func restartGame() {
        numberOfQuestions = 0
        score = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        //Return the booleans false
        besidesTheCorrect = false
        besidesTheWrong = false
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
