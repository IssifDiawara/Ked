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
            submitButton
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var title: some View {
        Text("🌴 \(viewModel.name)")
            .font(.title2)
            .padding(.bottom, -4)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var address: some View {
        VStack(alignment: .leading) {
            Text(viewModel.address)
            Text(viewModel.district)
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
            .foregroundColor(Color("Maroon"))
    }

    private var description: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .center, spacing: 4) {
                arrow
                Text("Espèce: \(viewModel.specie)")
            }

            HStack(alignment: .center, spacing: 4) {
                arrow
                Text("Genre: \(viewModel.type)")
            }

            HStack(alignment: .center, spacing: 4) {
                arrow
                Text("Domanialité: \(viewModel.domaniality)")
            }
        }
        .font(.body)
        .padding(.horizontal, 4)
        .padding(.bottom, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
    }


    @ViewBuilder
    private var submitButton: some View {
        if viewModel.isSelected {
            HStack(alignment: .center, spacing: 4) {
                moreInfoButton
                Spacer()
                closeButton
            }
        } else {
            moreInfoButton
        }
    }

    private var moreInfoButton: some View {
        Button("En savoir plus") {}
            .buttonStyle(SubmitButtonStyle(.more))
    }

    private var closeButton: some View {
        Button("Fermer", action: viewModel.close)
            .buttonStyle(SubmitButtonStyle(.close))
    }

    @ObservedObject private var viewModel: TreeRowViewModel

    init(viewModel: TreeRowViewModel) {
        self.viewModel = viewModel
    }

}

import CoreLocation

struct TreeRow_Previews: PreviewProvider {

    static var remarkableTreeFields = RemarkableTree.Fields(
        id: 123,
        type: "Cedrus",
        specie: "libani",
        name: "Cèdre",
        address: "GRANDE CASCADE - CARREFOUR DE LONGCHAMP",
        additionalAddress: "16-19",
        district: "BOIS DE BOULOGNE",
        coordinate: CLLocationCoordinate2D(latitude: 48.8633907267, longitude: 2.24048112696),
        domaniality: .garden,
        implementationDate: Date(),
        height: 25.0
    )

    static var previews: some View {
        TreeRow(viewModel: TreeRowViewModel(treeFields: remarkableTreeFields))
    }

}
