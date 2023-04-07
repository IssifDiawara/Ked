//
//  TreeRow.swift
//  Ked
//
//  Created by Issif DIAWARA on 07/04/2023.
//

import SwiftUI

struct TreeRow: View {

    var body: some View {
        VStack(spacing: 4) {
            title
            address
            description
            moreInfoButton
        }
        .padding(.leading, 4)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    var tree: RemarkableTree

    private var title: some View {
        Text("🌴 \(tree.fields.name)")
            .font(.title)
            .padding(.bottom, -4)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var address: some View {
        VStack(alignment: .leading) {
            Text((tree.fields.additionalAddress ?? "") + " " + tree.fields.address)
            Text(tree.fields.district.capitalized)
        }
        .font(.footnote)
        .opacity(0.6)
        .padding(.leading, 4)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var arrow: some View {
        Image(systemName: "arrow.right")
            .resizable()
            .frame(width: 10, height: 10)
            .foregroundColor(Color("lightGreen"))
    }

    private var description: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .center, spacing: 4) {
                arrow
                Text("Espèce: \(tree.fields.specie)")
            }

            HStack(alignment: .center, spacing: 4) {
                arrow
                Text("Genre: \(tree.fields.type)")
            }

            HStack(alignment: .center, spacing: 4) {
                arrow
                Text("Domanialité: \(tree.fields.domaniality.rawValue.lowercased())")
            }
        }
        .font(.body)
        .padding(.horizontal, 4)
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var moreInfoButton: some View {
        Button("Plus d'informations") {}
            .buttonStyle(SubmitButtonStyle())
            .padding(.horizontal, 24)
    }

}

struct TreeRow_Previews: PreviewProvider {

    static var remarkableTreeFields = RemarkableTree.Fields(
        type: "Cedrus",
        specie: "libani",
        name: "Cèdre",
        address: "GRANDE CASCADE - CARREFOUR DE LONGCHAMP",
        additionalAddress: "16-19",
        district: "BOIS DE BOULOGNE",
        coordinates: [48.8633907267, 2.24048112696],
        domaniality: .garden,
        implementationDate: Date(),
        height: 25.0
    )

    static var tree = RemarkableTree(fields: remarkableTreeFields)

    static var previews: some View {
        TreeRow(tree: tree)
    }

}
