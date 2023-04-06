//
//  SearchView.swift
//  Ked
//
//  Created by Issif DIAWARA on 03/04/2023.
//

import SwiftUI

struct SearchView: View {

    var body: some View {
        VStack {
            mapView
                .frame(height: 400)

            Spacer()
        }
        .onAppear {
            Task {
                try await viewModel.fetchTrees()
            }
        }
    }

    @ObservedObject var viewModel: SearchViewModel

    var mapView: some View {
        ZStack {
            MapView(
                centerCoordinate: $viewModel.centerCoordinate,
                annotations: $viewModel.annotations,
                selectedAnnotation: $viewModel.selectedAnnotation,
                shouldCenterAroundMe: $viewModel.shouldCenterAroundMe
            )

            centerButton
        }
    }

    var centerButton: some View {
        HStack {
            Spacer()

            Button(action: viewModel.centerAroundMe) {
                Image(systemName: "location.fill")
                    .foregroundColor(.white)
            }
            .frame(width: 50, height: 50)
            .background(Color.indigo)
            .clipShape(Circle())
            .offset(y: 150)
            .padding(.trailing, 24)
        }
    }

}
