//
//  TreeRowViewModel.swift
//  Ked
//
//  Created by Issif DIAWARA on 07/04/2023.
//

import Foundation

class TreeRowViewModel: ObservableObject {

    var name: String {
        treeFields.name
    }

    var address: String {
        (treeFields.additionalAddress ?? "") + " " + treeFields.address
    }

    var district: String {
        treeFields.district.capitalized
    }

    var specie: String {
        treeFields.specie
    }

    var type: String {
        treeFields.type
    }

    var domaniality: String {
        treeFields.domaniality.rawValue.lowercased()
    }

    private let treeFields: RemarkableTree.Fields

    init(treeFields: RemarkableTree.Fields) {
        self.treeFields = treeFields
    }

}

extension TreeRowViewModel: Identifiable {

    static func == (lhs: TreeRowViewModel, rhs: TreeRowViewModel) -> Bool {
        lhs.treeFields.id == rhs.treeFields.id
    }

}
