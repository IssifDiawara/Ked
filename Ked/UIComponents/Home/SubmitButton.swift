//
//  SubmitButton.swift
//  Ked
//
//  Created by Issif DIAWARA on 07/04/2023.
//

import SwiftUI

struct SubmitButtonStyle: ButtonStyle {

    enum `Type` {
        case more
        case close
    }

    private var type: `Type`

    init(_ type: Type) {
        self.type = type
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            .background(type == .more ? Color.indigo : Color("Maroon").opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }

}
