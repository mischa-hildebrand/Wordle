//
//  Toast.swift
//  Woerdl
//
//  Created by Mischa Hildebrand on 18.01.22.
//

import SwiftUI

struct ToastModifier: ViewModifier {

    @Binding var isVisible: Bool
    let message: String

    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .foregroundColor(.init(.sRGB, white: 1, opacity: 0.8))
                    .frame(minWidth: 100, minHeight: 20, maxHeight: 100, alignment: .center)
                    .overlay {
                        Text(message)
                            .font(.callout)
                            .lineLimit(5)
                            .multilineTextAlignment(.center)
                            .padding(8)
                    }
                    .scaledToFit()
                    .padding()
                Spacer()
            }
        }
    }
}

extension View {
    func toast(message: String, show: Binding<Bool>) -> some View {
        modifier(
            ToastModifier(
                isVisible: show,
                message: message
            )
        )
    }
}

struct ToastModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, Toast!")
            .modifier(
                ToastModifier(
                    isVisible: .constant(true),
                    message: "Hey, there! 🙃"
                )
            )
    }
}
