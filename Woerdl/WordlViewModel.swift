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
            mapStringToLetters()
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
        var newString = string
        if !isValidInput(string) {
            newString = lastString
        }
        
        if let truncatedString = truncateIfNeeded(newString) {
            newString = truncatedString
        }
        
        self.string = newString
        lastString = string
    }
    
    private func mapStringToLetters() {
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
    }
    
    private func guessedWord() -> String? {
        let finishedFullWord = string.count - activeRow * width == width
        guard finishedFullWord else {
            return nil
        }
        return String(string.suffix(width))
    }
    
    private func updateActiveRow(_ string: String) {
        activeRow = max(activeRow, string.count / width)
    }
    
    private func isValidInput(_ string: String) -> Bool {
        guard string.unicodeScalars.allSatisfy(allowedCharacters.contains) else {
            return false
        }
        return true
    }
    
    private func truncateIfNeeded(_ string: String) -> String? {
        let startIndex = activeRow * width
        let endIndex = startIndex + width - 1
        guard string.count <= endIndex + 1 else {
            // Keep old string in previous rows, use new string in current row, delete subsequent rows
            return String(lastString.prefix(startIndex)) + string.prefix(endIndex + 1).suffix(width)
        }
        guard string.count >= startIndex else {
            // Keep old string in previous rows, delete current row
            return String(lastString.prefix(endIndex))
        }
        return nil
    }
    
    private func evaluateWord(_ word: String) {
        print("Guessed word:", word)
    }
    
}
