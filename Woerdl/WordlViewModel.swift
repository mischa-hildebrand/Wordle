//
//  WordlViewModel.swift
//  Woerdl
//
//  Created by Mischa Hildebrand on 14.01.22.
//

import Foundation
import SwiftUI

class WordlViewModel: ObservableObject {

    let width = 5
    let height = 6

    @Published var currentIndex: Int = 0
    @Published var letters: [String] = [] {
        didSet {
            print(letters)
//            print(letters)
//            if let changedIndex = indexOfFirstNonEqualItem(oldArray: oldValue, newArray: letters) {
//                currentIndex = changedIndex + 1
//            }
//            var multipleCharactersIndex: Int?
//            for (index, letter) in letters.enumerated() {
//                if letter.count > 1 {
//                    multipleCharactersIndex = index
//                }
//            }
//            if let index = multipleCharactersIndex {
//                let letterCount = letters[index].count
//                let multipleCharacters = letters[index]
//                for letterIndex in 0...letterCount - 1 {
//                    let characterIndex = multipleCharacters.index(multipleCharacters.startIndex, offsetBy: letterIndex)
//                    let character = multipleCharacters[characterIndex]
//                    letters[index + letterIndex] = String(character)
//                }
//            }
        }
    }

    init() {
        letters = .init(repeating: .init(""), count: width * height)
    }

    func next(string: String?, at index: Int) {
//        print("--- nextString:", string!, "atIndex:", index)
        guard var string = string, !string.isEmpty else {
            currentIndex = index
            return
        }
        if index >= letters.endIndex {
            currentIndex = 0
        } else {
            if string.count > 1 {
                let firstCharacter = string.removeFirst()
                letters[index] = String(firstCharacter)
                next(string: string, at: index + 1)
            } else {
                currentIndex = index + 1
            }
        }
    }

//    private func indexOfFirstNonEqualItem<T: Equatable>(oldArray: Array<T>, newArray: Array<T>) -> Int? {
//        for (index, (old, new)) in zip(oldArray, newArray).enumerated() {
//            if old != new {
//                return index
//            }
//        }
//        return nil
//    }

}
