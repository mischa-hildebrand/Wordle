//
//  WordlViewModel.swift
//  Woerdl
//
//  Created by Mischa Hildebrand on 14.01.22.
//

import Foundation
import SwiftUI

class WordlViewModel: ObservableObject {

    let width: Int
    let height: Int

    @Published var letters: [[Character?]]
    
    var string: String = "" {
        didSet {
            for row in 0..<height {
                for column in 0..<width {
                    let currentIndex = row * width + column
                    if currentIndex >= string.count {
                        letters[row][column] = nil
                    } else {
                        letters[row][column] = [Character](string)[currentIndex]
                    }
                }
            }
            if let word = guessedWord() {
                evaluateWord(word)
            }
        }
    }

    init(width: Int = 5, height: Int = 6) {
        self.width = width
        self.height = height
        letters = Array(
            repeating: [Character?](repeating: nil, count: width),
            count: height
        )
    }
    
    private func guessedWord() -> String? {
        let finishedFullWord = string.count % width == 0
        guard finishedFullWord else {
            return nil
        }
        return String(string.suffix(width))
    }
    
    private func evaluateWord(_ word: String) {
        print("Guessed word:", word)
    }
    
}
