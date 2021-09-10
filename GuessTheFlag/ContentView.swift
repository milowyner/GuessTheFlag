//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Milo Wyner on 7/2/21.
//

import SwiftUI

struct ContentView: View {
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
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var wrongAnswer: Int?
    
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    @State private var showingAlert = false
    @State private var flagRotation = 0.0
    @State private var flagOpacity = 1.0
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            scoreMessage = "You gained 100 points!"
            score += 100
            
            withAnimation {
                flagRotation = 360
                flagOpacity = 0.25
            }
            flagRotation = 0
        } else {
            scoreTitle = "Incorrect!"
            scoreMessage = "That's the flag of \(countries[number]). You lost 50 points."
            if score >= 50 {
                score -= 50
            }
            
            withAnimation {
                wrongAnswer = number
            }
            wrongAnswer = nil
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            showingAlert = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        flagOpacity = 1
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
                .accessibilityElement(children: .combine)
                
                ForEach(0..<3) { number in
                    Button(action: {
                        flagTapped(number)
                    }, label: {
                        FlagImage(country: countries[number])
                            .accessibility(label: Text(labels[countries[number], default: "Unknown flag"]))
                            .rotation3DEffect(
                                .degrees(number == correctAnswer ? flagRotation : 0),
                                axis: (x: 0, y: 1, z: 0)
                            )
                            .opacity(number != correctAnswer ? flagOpacity : 1)
                            .modifier(Shake(toggle: number == wrongAnswer))
                    })
                }
                
                HStack(spacing: 0) {
                    Text("Your score is: ")
                    Text("\(score)")
                        .fontWeight(.bold)
                }
                .accessibilityElement(children: .combine)
                
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
