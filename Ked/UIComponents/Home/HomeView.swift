//
//  HomeView.swift
//  Ked
//
//  Created by Issif DIAWARA on 03/04/2023.
//

import SwiftUI

struct HomeView: View {

    var body: some View {
        VStack(alignment: .leading) {
            mapView
            title
            treeList
        }
        .onAppear {
            Task {
                try await viewModel.fetchTrees()
            }
        }
    }

    @ObservedObject var viewModel: HomeViewModel

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
        .frame(height: 400)
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

    private var title: some View {
        Text("Les arbres remarquables de Paris")
            .font(.title)
            .bold()
            .padding(.horizontal, 24)
    }

    var treeList: some View {
        ScrollView(showsIndicators: true) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach($viewModel.treeRowViewModels, id: \.id) { treeRowViewModel in
                    TreeRow(viewModel: treeRowViewModel.wrappedValue)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    divider
                }
            }
        }
    }

    private var divider: some View {
        Color("lightGray")
            .frame(height: 4)
            .frame(maxWidth: .infinity)
            .listRowInsets(EdgeInsets())
    }

}
