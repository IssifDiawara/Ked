//
//  SubmitButton.swift
//  Ked
//
//  Created by Issif DIAWARA on 07/04/2023.
//

import SwiftUI

struct SubmitButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            .background(Color("lightGreen").opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }

}
