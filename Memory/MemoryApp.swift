//
//  MemoryApp.swift
//  Memory
//
//  Created by Flavien Berthold on 16.05.2024.
//

import SwiftUI

@main
struct MemoryApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
