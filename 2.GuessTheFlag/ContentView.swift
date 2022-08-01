//
//  ContentView.swift
//  2.GuessTheFlag
//
//  Created by mostafa on 05/06/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var score = 0
    @State private var alertMessage = ""
    @State private var questionsCount = 0
    
    struct FlagImage: ViewModifier {
        
        func body(content: Content) -> some View {
            content
                .clipShape(Capsule())
                .shadow(radius: 5)
        }
    }

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text("\(countries[correctAnswer])")
                            .foregroundColor(.primary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image("\(countries[number])")
                                .renderingMode(.original)
                                .modifier(FlagImage())
                        }
                        
                        
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
            }.padding()
            
        }
        .alert(alertTitle, isPresented: $showAlert) {
            if questionsCount < 8 {
                Button("Continue", action: askQuestion)
            } else {
                Button("Restart", action: reset)
            }
        } message: {
            Text(alertMessage)
        }
    }
    
    func flagTapped(_ answer: Int) {
        showAlert = true
        if answer == correctAnswer {
            alertTitle = "Correct"
            alertMessage = ""
            score += 1
        } else {
            alertTitle = "Wrong"
            alertMessage = "This is \(countries[answer])"
        }
        if questionsCount == 8 {
            alertMessage = "Your final score is \(score)"
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionsCount += 1
        
    }
    
    func reset() {
        questionsCount = 0
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
