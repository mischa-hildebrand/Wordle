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
    
    private let allowedCharacters = CharacterSet.letters
    private var activeRow: Int = 0
    private var lastString: String = "" {
        didSet {
            updateActiveRow(lastString)
        }
    }

    @Published var letters: [[Character?]]
    
    @Published var string: String = "" {
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
    
    func validateString(_ string: String) {
        if !isValidInput(string) {
            self.string = lastString
        }
        lastString = string
    }
    
    private func guessedWord() -> String? {
        let finishedFullWord = string.count % width == 0
        guard finishedFullWord else {
            return nil
        }
        return String(string.suffix(width))
    }
    
    private func updateActiveRow(_ string: String) {
        activeRow = string.count / width
    }
    
    private func isEndOfStringInActiveRow(_ string: String) -> Bool {
        string.count / width == activeRow
    }
    
    private func isValidInput(_ string: String) -> Bool {
        guard string.unicodeScalars.allSatisfy(allowedCharacters.contains) else {
            return false
        }
        guard string.count >= lastString.count else {
            return isEndOfStringInActiveRow(string)
        }
        return true
    }
    
    private func evaluateWord(_ word: String) {
        print("Guessed word:", word)
    }
    
}
