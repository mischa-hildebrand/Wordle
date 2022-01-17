//
//  WordProvider.swift
//  Woerdl
//
//  Created by Mischa Hildebrand on 17.01.22.
//

import Foundation

struct WordProvider {
    
    let allowedWords: [String] = ["Table", "Chair", "Hello", "Happy"]
    
    func generateWord() -> String {
        allowedWords.randomElement()!
    }
    
}
