//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Rakibul Huda on 28/12/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State var alertIsVisibile = false
    @State var scoreTitle = ""
    @State var currentScore = 0
    
    var body: some View {
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    
                        Text("Your current socre is \(currentScore)")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                
                ForEach(0 ..< 3){ number in
                    Button(action: {
                        onFlagTapped(number: number)
                    }) {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.gray, lineWidth: 1))
                            .shadow(color: .gray, radius: 2)
                    }
                    
                }
                Spacer()
            }.padding(.top,30)
        }.alert(isPresented: $alertIsVisibile) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(currentScore)"), dismissButton: .default(Text("Continue")){
                resetQuestion()
            })
        }
        
    }
    
    func onFlagTapped(number : Int)  {
        if number == correctAnswer {
            scoreTitle = "Correct"
            currentScore += 1
        } else {
            scoreTitle = "Wrong. Thats flag of \(countries[number])"
        }
        alertIsVisibile = true
    }
    
    func resetQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
