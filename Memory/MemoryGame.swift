//
//  MemoryGame.swift
//  Memory
//
//  Created by Flavien Berthold on 19.05.2024.
//

import Foundation

//we want this logic to work with any content type. This is why we use a "generic" here, mentioning <CardContent>
struct MemoryGame<CardContent> where CardContent: Equatable {
    //private(set) is alsmost the same as private, but only setting a value to the var is private, reading is allowed from ext
    private(set) var cards: [Card] //the previous notation was: Array<Card>, but I prefere [Card] to define an arra
    
    
    //one of the parameter of the init is a function here...
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        //_ is used as we don't need an index in the for loop
        
        //max(2,... is used to get a least two pair of cards...
        for pairIndex in 0..<max(2, numberOfPairsOfCards){
            let content  = cardContentFactory(pairIndex)
            cards.append(Card(Content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(Content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    mutating func choose(_ card: Card){
        print("chose \(card)")
        var chosenIndex = index(of: card)
        cards[chosenIndex].IsFacedUp.toggle()
    }
    
    func index(of card: Card) -> Int{
        for index in cards.indices{
            if cards[index].id == card.id{
                return index
            }
        }
        return 0 // FIXME: bogus!
        
    }
    
    // mutating is mandatory, because the model itseld is immutable. So the functions modifying the model has to be marked as "mutating"
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible{
        
        /*static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            return lhs.IsFacedUp == rhs.IsFacedUp &&
            lhs.IsMatched == rhs.IsMatched &&
            lhs.Content == rhs.Content
        }*/
        // this all code ensuring that Card is Equatable is actually implicit in Siwft and therefore not needed.
        
        var IsFacedUp: Bool = true
        var IsMatched: Bool = false
        let Content: CardContent
        
        var id: String
        
        //this var is used to ease debugging by formatting a desired struct into a readable string
        var debugDescription: String {
            "\(id): \(Content) \(IsFacedUp ? "up" : "down" ) \(IsMatched ? "matched" : "")"
        }
        
    }
    
}
