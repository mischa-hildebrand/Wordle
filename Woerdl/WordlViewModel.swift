//
//  WordlViewModel.swift
//  Woerdl
//
//  Created by Mischa Hildebrand on 14.01.22.
//

import Foundation

enum LetterEvalutation {
    case noMatch
    case included
    case match
}

class WordlViewModel: ObservableObject {

    let width: Int
    let height: Int

    @Published var solved: Bool = false
    @Published var lost: Bool = false
    @Published var letters: [[Character?]]
    @Published var evaluation: [[LetterEvalutation?]] = []
    @Published var string: String = ""

    var solution: String = ""
    
    private let wordProvider = WordProvider()
    private let allowedCharacters = CharacterSet.letters
    private var activeRow: Int = 0

    init(width: Int = 5, height: Int = 6) {
        self.width = width
        self.height = height
        letters = Array(
            repeating: .init(repeating: nil, count: width),
            count: height
        )
        evaluation = Array(
            repeating: .init(repeating: nil, count: width),
            count: height
        )
        newGame()
    }

    func newGame() {
        activeRow = 0
        string = ""
        evaluation = evaluation.map { $0.map { _ in nil }}
        solution = wordProvider.generateWord()
    }

    func validateString(_ newString: String, previousString: String) {
        let validatedString = newString
            .transform { string in
                validateAllowedCharacters(string, previousString: previousString)
            }
            .transform { string in
                truncateIfNeeded(string, previousString: previousString)
            }
        string = validatedString
        mapStringToLetters(validatedString)
        if let word = guessedWord() {
            evaluateWord(word)
        }
    }
    
    private func mapStringToLetters(_ string: String) {
        for row in 0..<height {
            for column in 0..<width {
                let index = row * width + column
                if index < string.count {
                    letters[row][column] = [Character](string)[index]
                } else {
                    letters[row][column] = nil
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
    
    private func isValidInput(_ string: String) -> Bool {
        let allowedCharacters = CharacterSet.letters
        return string.unicodeScalars.allSatisfy(allowedCharacters.contains)
    }

    private func validateAllowedCharacters(_ string: String, previousString: String) -> String {
        guard isValidInput(string) else {
            return previousString
        }
        return string
    }
    
    private func truncateIfNeeded(_ string: String, previousString: String) -> String {
        let startIndex = activeRow * width
        let endIndex = startIndex + width - 1
        guard string.count <= endIndex + 1 else {
            // Keep old string in previous rows, use new string in current row, delete subsequent rows
            return String(previousString.prefix(startIndex)) + string.prefix(endIndex + 1).suffix(width)
        }
        guard string.count >= startIndex else {
            // Keep old string in previous rows, delete current row
            return String(previousString.prefix(endIndex))
        }
        return string
    }

    private func evaluateWord(_ word: String) {
        let solution = Array(solution.uppercased())
        let rowEvaluation: [LetterEvalutation] = word
            .uppercased()
            .enumerated()
            .map { index, character in
                if character == solution[index] {
                    return .match
                } else if solution.contains(character) {
                    return .included
                } else {
                    return .noMatch
                }
        }
        evaluation[activeRow] = rowEvaluation
        handleRowEvaluation(rowEvaluation)
        activeRow += 1
        print("Guessed word:", word, "solution:", solution, "evaluation:", rowEvaluation)
    }

    private func handleRowEvaluation(_ rowEvalutation: [LetterEvalutation]) {
        if rowEvalutation.solved {
            solved = true
        } else if activeRow == height - 1 {
            lost = true
        }
    }
    
}

extension String {

    func transform(_ transform: (String) -> String) -> String {
        transform(self)
    }

}

extension Array where Element == LetterEvalutation {

    var solved: Bool {
        allSatisfy { $0 == .match }
    }

}
