//
//  LetterBox.swift
//  Woerdl
//
//  Created by Mischa (Privat) on 16.01.22.
//

import SwiftUI

struct LetterBox: View {
    let letter: Character?
    let evaluation: LetterEvalutation?
    
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 4)
                .style(withStroke: Color.letterBoxStroke, lineWidth: 1, fill: backgroundColor)
                .aspectRatio(1, contentMode: .fit)
            if let letter = letter {
                Text(String(letter))
                    .textCase(.uppercase)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.letterBoxText)
            }
        }
    }

    private var backgroundColor: Color {
        guard let evaluation = evaluation else {
            return .letterBoxBackground
        }
        return evaluation.backgroundColor
    }
}

struct LetterBox_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LetterBox(letter: .init("A"), evaluation: nil)
                .previewLayout(.fixed(width: 100, height: 100))
                .environment(\.colorScheme, .light)
            LetterBox(letter: .init("A"), evaluation: nil)
                .previewLayout(.fixed(width: 100, height: 100))
                .environment(\.colorScheme, .dark)
        }
    }
}

private extension LetterEvalutation {
    var backgroundColor: Color {
        switch self {
        case .noMatch:
            return .letterBoxBackground
        case .included:
            return .included
        case .match:
            return .matching
        }
    }
}
