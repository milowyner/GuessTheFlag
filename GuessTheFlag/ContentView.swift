//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Milo Wyner on 7/2/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    @State private var showingAlert = false
    @State private var flagRotation = 0.0
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            scoreMessage = "You gained 100 points!"
            score += 100
            
            withAnimation {
                flagRotation = 360
            }
            flagRotation = 0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                showingAlert = true
            }
        } else {
            scoreTitle = "Incorrect!"
            scoreMessage = "That's the flag of \(countries[number]). You lost 50 points."
            if score >= 50 {
                score -= 50
            }
            
            showingAlert = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        flagTapped(number)
                    }, label: {
                        FlagImage(country: countries[number])
                            .rotation3DEffect(
                                .degrees(number == correctAnswer ? flagRotation : 0),
                                axis: (x: 0, y: 1, z: 0)
                            )
                    })
                }
                
                HStack(spacing: 0) {
                    Text("Your score is: ")
                    Text("\(score)")
                        .fontWeight(.bold)
                }
                
                Spacer()
            }
            .foregroundColor(.white)
        }
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue"), action: {
                askQuestion()
            }))
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
