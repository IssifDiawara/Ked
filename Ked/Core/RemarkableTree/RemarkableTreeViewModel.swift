//
//  RemarkableTreeViewModel.swift
//  Ked
//
//  Created by Issif DIAWARA on 07/03/2023.
//

import Foundation
import Combine

class RemarkableTreeViewModel: ObservableObject {

    @Published var trees: [RemarkableTree] = []

    let session: Session

    private var disposables: Set<AnyCancellable> = []
    
    init(session: Session) {
        self.session = session
        
        $trees
            .dropFirst()
            .sink { trees in
                print(trees.count)
                print(trees.first?.fields)
            }
            .store(in: &disposables)
    }

    func onAppear() async throws {
        let request: Request = .remarkableTree(limit: 1)
        trees = try await session.loadItems(for: request)
    }

}
