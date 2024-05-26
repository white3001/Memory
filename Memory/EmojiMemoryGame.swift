//
//  EmojiMemoryGame.swift
//  Memory
//
//  Created by Flavien Berthold on 19.05.2024.
//

import SwiftUI

// the ObsevableObject protocol is required to make the class behave like a view
class EmojiMemoryGame :ObservableObject {
    //private static will malke the emojis var global, ensuring it will be initalized before the rest of this class
    
    private static let emojis = ["👻", "🐙", "🐨", "🐹", "🐬", "🐸","🐯","🐣","🐴","🦋","🐓","🐶"]
    //making this variable private, so it cannot be accessed form the outside
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 12) { pairIndex in
            if emojis.indices.contains(pairIndex){
                return EmojiMemoryGame.emojis[pairIndex]
            } else{
                return "⁉️"
            }
        }
    }
    @Published private var model = createMemoryGame()
        
    
    var cards: [MemoryGame<String>.Card]{
        return model.cards
    }
    
    
    // MARK: - Intents
    
    func shuffle(){
        model.shuffle()
    }
    
    
    //_ is to mention taht there is no label when calling the function
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
    
    
}
