//
//  ContentView.swift
//  project2
//
//  Created by Student on 9/26/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "UK", "US", "Poland", "Spain", "Ireland", "Italy"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false;
    @State private var scoreTitle = ""
    @State private var score = 0
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 25){
                VStack{
                    Text("select the flag of").foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3){ number in
                    Button(action: {
                        self.flagTapped(number)
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1.5))
                            .shadow(color: .black, radius: 2)
                    }
                }
                Text("Current Score is \(score)")
                    .foregroundColor(.white)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore){
            Alert(title: Text(scoreTitle), message: Text("current score: \(score)"), dismissButton: .default(Text("proceed")) {
                self.askQuestion()
            })
        }
    }
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Incorrect"
            score -= 1
        }
        showingScore = true;
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

    }
}
struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
