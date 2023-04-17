//
//  HomeViewModel.swift
//  Ked
//
//  Created by Issif DIAWARA on 07/03/2023.
//

import Foundation
import Combine
import CoreLocation
import MapKit

@MainActor
class HomeViewModel: ObservableObject {

    @Published private var trees: [RemarkableTree] = []
    @Published var treeRowViewModels: [TreeRowViewModel] = []
    @Published var focusedTreeViewModel: TreeRowViewModel?

    @Published var centerCoordinate: CLLocationCoordinate2D?
    @Published var annotations: [MKPointAnnotation]?
    @Published var selectedAnnotation: MKPointAnnotation?
    @Published var shouldCenterAroundMe = true

    private let session: Session

    private var disposables: Set<AnyCancellable> = []

    init(session: Session) {
        self.session = session

        treesBinding()
        selectedAnnotationBinding()
    }

    private func treesBinding() {
        $trees
            .filter { !$0.isEmpty }
            .sink { [weak self] trees in
                let coordinates = trees.map(\.fields.coordinate)
                self?.annotations = coordinates.map {
                    let pointAnnotation = MKPointAnnotation()
                    pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
                    return pointAnnotation
                }
            }
            .store(in: &disposables)

        $trees
            .filter { !$0.isEmpty }
            .sink { [weak self] trees in
                self?.treeRowViewModels = trees.map {
                    TreeRowViewModel(treeFields: $0.fields)
                }
            }
            .store(in: &disposables)
    }

    private func focusedTreeViewModelBinding() {
        focusedTreeViewModel?.$isSelected
            .filter { !$0 }
            .sink { [weak self] viewModel in
                self?.selectedAnnotation = nil
                self?.focusedTreeViewModel = nil
            }
            .store(in: &disposables)
    }

    private func selectedAnnotationBinding() {
        $selectedAnnotation
            .compactMap { $0 }
            .sink { [weak self] annotation in
                let focusedTree = self?.trees.first(where: { $0.fields.coordinate == annotation.coordinate })

                guard let focusedTree else { return }
                self?.focusedTreeViewModel = TreeRowViewModel(treeFields: focusedTree.fields, isSelected: true)

                self?.focusedTreeViewModelBinding()
            }
            .store(in: &disposables)
    }

    func fetchTrees() async throws {
        let request: Request = .remarkableTree(limit: 50)
        trees = try await session.loadItems(for: request)
    }

    func centerAroundMe() {
        shouldCenterAroundMe.toggle()
    }

    func deselectTree() {
        focusedTreeViewModel = nil
    }

}
