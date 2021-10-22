//
//  EmojiMemoryGame.swift
//  CS193p-Memorize
//
//  Created by Troy Thomas York on 7/31/21.
//

import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
    typealias Card = EmojiMemoryGame<String>.Card
    
    private static let emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🦽", "🦼", "🛴", "🚲", "🛵", "🏍", "🛺", "🚔", "🚍", "🚀"]
    private static func createMemoryGame() -> EmojiMemoryGame<String> {
        EmojiMemoryGame<String>(numberOfPairsOfCards: 8) { pairIndex  in
            emojis[pairIndex]
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> { model.cards }
    
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = Self.createMemoryGame()
    }
}
