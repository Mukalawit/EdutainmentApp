//
//  ContentView.swift
//  EdutainmentApp
//
//  Created by Anthony Mugasa Jr on 15/02/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var number:Int = 1
    @State private var questions:Int = 0
    @State private var showingResult = false
    @State private var finalScore:Int = 0
    @State private var startOptions:String = ""
    @State private var startShow = false
    @State private var scoreResult = ""
    @State private var answer:Int = 0
    @State private var answeredQuestions:Int = 0
    @State private var multiplier:Int = Int.random(in: 1...12)
    var multiplyingNumber:Int{
        number + 1
    }
    
    var numberOfQuestions:Int{
        questions + 1
    }
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State private var cuties:[String] = ["bear","buffalo","chick","chicken","cow","crocodile","dog","duck","elephant","frog","giraffe","goat","gorilla","hippo","horse","monkey","moose","narwhal","owl","panda","parrot","penguin","pig","rabbit","rhino","sloth","snake","walrus","whale","zebra"].shuffled()

    @State private var chosenLevel:String = "Easy"
    @State private var randomPick:Int = Int.random(in: 0...29)
    var body: some View {
        NavigationView{
            Form{
                VStack{
                    Text("I am Playing \(chosenLevel)")
                    Picker("Ask Me",selection: $questions){
                        ForEach(1..<13){number in
                           Text("\(number) Question(s)")
                        }
                    }
                }
                VStack{
                   
                    Text("Select the number you would love to play multiples with")
                    Picker("Select your number", selection: $number){
                        
                        ForEach(1..<13){
                            Text("\($0)")
                        }
                    }
                }
                
                VStack{
                    HStack{
                        LazyVGrid(columns:columns){
                            ForEach(-1..<number, id:\.self ){_ in
                                Image(cuties[randomPick])
                                    .resizable()
                                    .frame(width:50,height: 50)
                            }
                        }
                        
                    }
                        
                }
                VStack{
                   Text("X")
                        .font(.system(size:36))
                }
                    VStack{
                        LazyVGrid(columns: columns){
                            ForEach(1...multiplier, id: \.self){_ in
                                
                                Image(cuties[randomPick])
                                    .resizable()
                                    .frame(width:50,height:50)
                            }
                        }
                        
                    }
                VStack{
                    TextField("My answer",value:$answer,formatter: NumberFormatter())
                    
                }
            }
            .onSubmit(makeComparison)
            .navigationTitle("Edutainment App")
            .toolbar{
                Button("Start Game", action:startPlaying)
            }
           
        }
        .alert(scoreResult, isPresented: $showingResult){
            if numberOfQuestions == answeredQuestions{
                Button("Your final score is \(finalScore) out of \(numberOfQuestions)",action:resetGame)
            }else{
                Button("Continue",action:continuePlaying)
            }
            
        }
        .alert(startOptions, isPresented:$startShow){
            Button("Easy"){
               chosenLevel = "Easy"
                multiplier = playLevel(level: chosenLevel)
            }
            Button("Medium"){
                chosenLevel = "Medium"
                multiplier = playLevel(level: chosenLevel)
            }
            Button("Hard"){
                chosenLevel = "Hard"
                multiplier = playLevel(level: chosenLevel)
            }
        }
    }
    
    func makeComparison(){
     
        if answer == multiplier * multiplyingNumber{
            scoreResult = "Correct"
            showingResult = true
            finalScore += 1
            answeredQuestions += 1
        }else{
            scoreResult = "Try again"
            showingResult = true
            answeredQuestions += 1
        }
    }
    
    func continuePlaying(){
        multiplier = playLevel(level: chosenLevel)
        showingResult = false
        answer = 0
    }
    
    func startPlaying(){
        startShow = true
        startOptions = "What level do want to play"
    }
    
    func resetGame(){
        answeredQuestions = 0
        questions = 0
        finalScore = 0
    }
    
    func playLevel(level:String)->Int{
        
        if level == "Easy"{
            return Int.random(in: 1...4)
        }
        else if level == "Medium"{
            return Int.random(in: 5...8)
        }
        else if level == "Hard"{
            return Int.random(in: 9...12)
        }
        else{
            return Int.random(in: 1...4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
