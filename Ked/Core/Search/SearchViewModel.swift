//
//  SearchViewModel.swift
//  Ked
//
//  Created by Issif DIAWARA on 07/03/2023.
//

import Foundation
import Combine
import CoreLocation
import MapKit

@MainActor
class SearchViewModel: ObservableObject {

    @Published var trees: [RemarkableTree] = []
    @Published var remarkableTreeCoordinate: [RemarkableTreeCoordinate] = []
    @Published var centerCoordinate = MKCoordinateRegion()

    // Default coordinate
    let center = CLLocationCoordinate2D(latitude: 48.85652, longitude: 2.34892)
    let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)

    let session: Session

    private var disposables: Set<AnyCancellable> = []

    init(session: Session) {
        self.session = session
        centerCoordinate = MKCoordinateRegion(center: center, span: span)
        treesBinding()
    }

    private func treesBinding() {
        $trees
            .filter { !$0.isEmpty }
            .sink { [weak self] trees in
                self?.remarkableTreeCoordinate = trees.map { tree in
                    let lat = tree.fields.coordinates[0]
                    let long = tree.fields.coordinates[1]
                    return RemarkableTreeCoordinate(lat: lat, long: long)
                }
            }
            .store(in: &disposables)
    }

    func fetchTrees() async throws {
        let request: Request = .remarkableTree(limit: 10)
        trees = try await session.loadItems(for: request)
    }

}
