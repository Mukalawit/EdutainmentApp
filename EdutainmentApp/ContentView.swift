//
//  ContentView.swift
//  EdutainmentApp
//
//  Created by Anthony Mugasa Jr on 15/02/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var number:Int = 1
    @State private var showingResult = false
    @State private var scoreResult = ""
    @State private var answer:Int? = nil
    @State private var multiplier:Int = Int.random(in: 1...12)
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State private var cuties:[String] = ["bear","buffalo","chick","chicken","cow","crocodile","dog","duck","elephant","frog","giraffe","goat","gorilla","hippo","horse","monkey","moose","narwhal","owl","panda","parrot","penguin","pig","rabbit","rhino","sloth","snake","walrus","whale","zebra"].shuffled()
    
    @State private var randomPick:Int = Int.random(in: 0...29)
    var body: some View {
        NavigationView{
            Form{
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
                        ForEach(-1..<number, id:\.self ){_ in
                            Image(cuties[randomPick])
                                .resizable()
                                .frame(width:50,height: 50)
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
           
        }
        .alert(scoreResult, isPresented: $showingResult){
            Button("Continue",action:continuePlaying)
        }
    }
    
    func makeComparison(){
        guard let answer = answer else{
            scoreResult = "Try again"
            showingResult = true
            return
        }
        if answer == multiplier * number{
            scoreResult = "Correct"
            showingResult = true
        }else{
            scoreResult = "Try again"
            showingResult = true
        }
    }
    
    func continuePlaying(){
        multiplier = Int.random(in: 1...12)
        showingResult = false;
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
