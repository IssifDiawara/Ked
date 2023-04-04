//
//  MapView.swift
//  Ked
//
//  Created by Issif DIAWARA on 03/04/2023.
//

import SwiftUI
import MapKit

struct MapView: View {

    @Binding var annotations: [RemarkableTreeCoordinate]
    @Binding var centerCoordinates: MKCoordinateRegion

    var body: some View {
        Map(coordinateRegion: $centerCoordinates, annotationItems: annotations) {
            MapAnnotation(coordinate: $0.coordinate, content: treeImage)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    @ViewBuilder
    func treeImage() -> some View {
        Image(systemName: "tree")
            .renderingMode(.template)
            .resizable()
            .frame(width: 40, height: 40)
    }

}
