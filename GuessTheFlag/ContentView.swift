//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Milo Wyner on 7/2/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    
    func flagTapped(_ number: Int) {
        scoreTitle = "\(number == correctAnswer ? "Correct" : "Incorrect")!"
        showingAlert = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                }
                .foregroundColor(.white)
                
                ForEach(0..<3) { number in
                    Button(action: {
                        flagTapped(number)
                    }, label: {
                        Image(countries[number])
                            .renderingMode(.original)
                    })
                }
                
                Spacer()
            }
        }
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text(scoreTitle), message: Text("Your score is ???"), dismissButton: .default(Text("Play again"), action: {
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
