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

    @Published var centerCoordinate: CLLocationCoordinate2D?
    @Published var annotations: [MKPointAnnotation]?
    @Published var selectedAnnotation: MKPointAnnotation?
    @Published var shouldCenterAroundMe = true

    private let session: Session

    private var disposables: Set<AnyCancellable> = []

    init(session: Session) {
        self.session = session

        treesBinding()
    }

    private func treesBinding() {
        $trees
            .filter { !$0.isEmpty }
            .sink { [weak self] trees in
                self?.annotations = trees.map { tree in
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(
                        latitude: tree.fields.coordinates[0],
                        longitude: tree.fields.coordinates[1]
                    )

                    return annotation
                }

                self?.treeRowViewModels = trees.map { TreeRowViewModel(treeFields: $0.fields) }
            }
            .store(in: &disposables)
    }

    func fetchTrees() async throws {
        let request: Request = .remarkableTree(limit: 20)
        trees = try await session.loadItems(for: request)
    }

    func centerAroundMe() {
        shouldCenterAroundMe.toggle()
    }

}
