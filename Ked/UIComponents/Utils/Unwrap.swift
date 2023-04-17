//
//  Unwrap.swift
//  Ked
//
//  Created by Issif DIAWARA on 11/04/2023.
//

import SwiftUI

struct Unwrap<Value, Content: View>: View {

    private let value: Value?
    private let contentProvider: (Value) -> Content

    var body: some View {
        value.map(contentProvider)
    }

    init(_ value: Value?, @ViewBuilder content: @escaping (Value) -> Content) {
        self.value = value
        self.contentProvider = content
    }
}
