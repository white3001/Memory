//
//  ContentView.swift
//  Memory
//
//  Created by Flavien Berthold on 16.05.2024.
//

import SwiftUI

struct ContentView: View {
    @State var cardCount: Int = 5
    let emojis = ["👻", "🐙", "🐲", "🐹", "🐬", "🐸","🪲","🐣","🐴","🐞","🐓","🐿️"]
    var body: some View {
        VStack{
            ScrollView{
                cards
            }
            Spacer()
            cardsAdjuster
        }.padding()
        
       
    }
    //by is the external name, offset is the internal name
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View{
        Button(action: {
            cardCount+=offset
        }, label: {
            Image(systemName: symbol)
        }).disabled(cardCount+offset < 1 || cardCount+offset > emojis.count)
    }
    
    var cardAdder: some View{
        //return is implicit and would not be needed actually
        return cardCountAdjuster(by: 1, symbol: "plus.circle.fill")
    }
    
    var cardRemover: some View {
        return cardCountAdjuster(by: -1, symbol: "minus.circle.fill")
    }
    
    var cardsAdjuster: some View{
        HStack{
            cardAdder
            Spacer()
            cardRemover
             
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]){
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
            }.aspectRatio(2/2, contentMode: .fit)
            
        }
    }
    
}

#Preview {
    ContentView()
}

struct CardView: View {
    var content: String
    @State var IsFaceUp = true
   
    var body: some View {
        
        ZStack {
            let base  = RoundedRectangle(cornerRadius: 12)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(IsFaceUp ? 1 : 0)
            base.fill().opacity(IsFaceUp ? 0 : 1)
            
                
        }
        .onTapGesture {
            print("tapped")
            IsFaceUp.toggle()
        }
    }
}
