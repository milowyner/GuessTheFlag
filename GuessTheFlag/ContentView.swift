//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Milo Wyner on 7/2/21.
//

import SwiftUI

struct ContentView: View {
    @State private var alertIsShowing = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var guess: Int!
    
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
                        alertIsShowing = true
                        guess = number
                    }, label: {
                        Image(countries[number])
                            .renderingMode(.original)
                    })
                    .alert(isPresented: $alertIsShowing, content: {
                        Alert(title: Text("\(guess == correctAnswer ? "Correct" : "Incorrect")!"), message: Text("You guessed \(countries[guess])!"), dismissButton: .default(Text("Play again"), action: {
                            countries.shuffle()
                            correctAnswer = Int.random(in: 0...2)
                        }))
                    })
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
