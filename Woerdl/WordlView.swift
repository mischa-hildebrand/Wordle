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
    @FocusState private var textFieldActive: Bool

    var body: some View {
        VStack {
            ZStack {
                TextField("", text: $viewModel.string)
                    .keyboardType(.asciiCapable)
                    .disableAutocorrection(true)
                    .focused($textFieldActive)
                    .opacity(0)
                    .onChange(of: viewModel.string) { [oldString = viewModel.string] newString in
                        viewModel.validateString(newString, previousString: oldString)
                    }
                MatrixGrid(
                    width: viewModel.width,
                    height: viewModel.height,
                    spacing: 8
                ) { row, column in
                    LetterBox(
                        letter: viewModel.letters[row][column],
                        evaluation: viewModel.evaluation[row][column]
                    )
                    .id("LetterBox_\(row)×\(column)")
                }
                Button {
                    textFieldActive.toggle()
                } label: {
                    Color.clear
                }
            }
            Button("New Game") {
                withAnimation {
                    viewModel.newGame()
                }
            }
            .padding(8)
        }
        .padding([.horizontal], 32)
        .padding([.vertical], 24)
        .background(Color.appBackground)
        .alert("You won! 🎉", isPresented: $viewModel.solved) {
            Button("OK", role: .none) {
                viewModel.solved = false
            }
        }
        .alert("You lost! 🥺", isPresented: $viewModel.lost) {
            Button("OK", role: .none) {
                viewModel.lost = false
            }
        } message: {
            Text("The word was:\n" + viewModel.solution.uppercased())
        }
        .onChange(of: viewModel.solved) { solved in
            if solved {
                vibrate(type: .success)
            }
        }
        .onChange(of: viewModel.lost) { lost in
            if lost {
                vibrate(type: .error)
            }
        }
    }
    
    private func vibrate(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                WordlView().environment(\.colorScheme, .light)
            }
            VStack {
                WordlView().environment(\.colorScheme, .dark)
            }
        }
    }
}

