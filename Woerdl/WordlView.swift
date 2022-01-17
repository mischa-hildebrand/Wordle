//
//  ContentView.swift
//  Woerdl
//
//  Created by Mischa Hildebrand on 14.01.22.
//

import Combine
import SwiftUI

struct WordlView: View {

    @StateObject private var viewModel = WordlViewModel()
    @FocusState private var showTextField: Bool
    
    private var columns: [GridItem] {
        .init(repeating: GridItem(.flexible()), count: viewModel.width)
    }

    private var squareCount: Int {
        viewModel.width * viewModel.height
    }
    
    var body: some View {
        ZStack {
            LazyVGrid(columns: columns, alignment: .center, spacing: 8) {
                ForEach(0..<viewModel.height) { row in
                    ForEach(0..<viewModel.width) { column in
                        LetterBox(
                            letter: viewModel.letters[row][column],
                            evaluation: viewModel.evaluation[row][column]
                        )
                        .id("LetterBox_\(row)×\(column)")
                    }
                }
            }
            TextField("", text: $viewModel.string)
                .keyboardType(.asciiCapable)
                .disableAutocorrection(true)
                .focused($showTextField)
                .opacity(0)
                .onChange(of: viewModel.string, perform: viewModel.validateString)
            Button {
                showTextField.toggle()
            } label: {
                Color.clear.contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .padding()
        .background(Color.background)
        .alert("You won! 🎉", isPresented: $viewModel.solved) {
            Button("New Game", role: .none) {
                viewModel.newGame()
            }
        }

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                WordlView()
            }
            VStack {
                WordlView().environment(\.colorScheme, .dark)
            }
        }
    }
}
