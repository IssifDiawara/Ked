//
//  SearchView.swift
//  Ked
//
//  Created by Issif DIAWARA on 03/04/2023.
//

import SwiftUI

struct SearchView: View {

    var body: some View {
        VStack(spacing: 0) {
            MapView(
                annotations: $viewModel.remarkableTreeCoordinate,
                centerCoordinates: $viewModel.centerCoordinate
            )
        }
        .onAppear {
            Task {
                try await viewModel.fetchTrees()
            }
        }
    }

    @ObservedObject var viewModel: SearchViewModel

}
