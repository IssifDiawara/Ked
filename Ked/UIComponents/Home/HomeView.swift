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

            if viewModel.focusedTreeViewModel == nil {
                title
                treeList
            } else {
                focusedTree
            }
        }
        .onAppear {
            Task {
                try await viewModel.fetchTrees()
            }
        }
    }

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

            Button { viewModel.centerAroundMe() } label: {
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

    private var focusedTree: some View {
        Unwrap(viewModel.focusedTreeViewModel, content: TreeRow.init(viewModel:))
    }

    @StateObject private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

}
