//
//  ContentView.swift
//  Edutainment
//
//  Created by CEVAT UYGUR on 6.03.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var multiplication = 2
    @State private var numberOfQuestions = 5
    @State private var gameisActive = false
    @State private var questionsArray1 = [Int]()
    @State private var questionsArray2 = [Int]()
    @State private var questionitem1 = 0
    @State private var askedQuestionNumber = 1
    @State private var result = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
    
        NavigationView {
            Form {
                if !gameisActive {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Please select the number of questions between 5 and 20:")
                            .font(.headline)
                        Stepper("\(numberOfQuestions)", value: $numberOfQuestions, in: 5...20, step: 1)
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Please select the multiplication table up to: ")
                            .font(.headline)
                        Stepper("\(multiplication)", value: $multiplication, in: 2...12, step: 1)
                    }
                } else {
                    VStack {
                        Text("\(askedQuestionNumber). Question: \n\nWhat is te result of \(questionsArray1[questionitem1]) times \(questionsArray2[questionitem1]) ?")
                    }
                    VStack {
                        TextField("Enter your answer", value: $result, format: .number)
                            .keyboardType(.numberPad)
                    }
                    VStack {
                        Button{
                            showingScore = true
                            checkResult()
                        }label: {
                            Text("Submit")
                        }
                    }
                }
            }
            .navigationTitle("Edutainment")
            
            .toolbar {
                if !gameisActive {
                    Button("Start Game", action: startGame)
                } else {
                    Button("End Game", action: endGame)
                }
            }
        }
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("\(askedQuestionNumber < numberOfQuestions ? "Continue" : "Restart")", action: askedQuestionNumber < numberOfQuestions ? askQuestion : endGame)
        } message: {
            Text("\(askedQuestionNumber < numberOfQuestions ? "Your score is \(score)" : "Game Over\nYour score is \(score)")" )
        }
    }
    
    func startGame() {
        gameisActive = true
        for _ in 0..<numberOfQuestions {
            questionsArray1.append(Int.random(in: 2...multiplication))
            questionsArray2.append(Int.random(in: 2...multiplication))
        }
    }
    
    func askQuestion() {
        result = 0
        questionitem1 += 1
        askedQuestionNumber += 1
    }
    
    func endGame() {
        gameisActive = false
        multiplication = 2
        numberOfQuestions = 5
        questionsArray1.removeAll()
        questionsArray2.removeAll()
        askedQuestionNumber = 1
        questionitem1 = 0
        score = 0
        result = 0
    }
    
    func checkResult() {
    
        if result == questionsArray1[questionitem1] * questionsArray2[questionitem1] {
            scoreTitle = "Correct Answer"
            score += 1
        } else {
            scoreTitle = "Wrong Answer\nCorrect answer is \(questionsArray1[questionitem1] * questionsArray2[questionitem1])"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
