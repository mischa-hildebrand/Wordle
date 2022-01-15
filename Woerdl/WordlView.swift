//
//  ContentView.swift
//  Woerdl
//
//  Created by Mischa Hildebrand on 14.01.22.
//

import Combine
import SwiftUI

struct WordlView: View {

    @ObservedObject var viewModel = WordlViewModel()

    struct FocusedFieldIndex: Hashable {
        let index: Int
    }

    @FocusState var focusedField: FocusedFieldIndex?

    private var columns: [GridItem] {
        .init(repeating: GridItem(.flexible()), count: viewModel.width)
    }

    var squareCount: Int {
        viewModel.width * viewModel.height
    }

    var body: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 8) {
                ForEach(0...squareCount - 1, id: \.self) { index in
                    ZStack() {
                        Rectangle()
                            .aspectRatio(1, contentMode: .fill)
                            .cornerRadius(4)
                        TextField("•", text: $viewModel.letters[index])
                            .multilineTextAlignment(.center)
                            .font(.system(.title))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .onChange(of: viewModel.letters[index]) { newValue in
                                viewModel.next(string: newValue, at: index)
                                focusedField = .init(index: viewModel.currentIndex)
                            }
                            .focused($focusedField, equals: .init(index: index))
                    }
                }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WordlView()
    }
}
