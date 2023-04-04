//
//  TabView.swift
//  Ked
//
//  Created by Issif DIAWARA on 01/04/2023.
//

import SwiftUI
import CoreLocation

struct TabView: View {

    let coordinates = CLLocationCoordinate2D(latitude: 48.8265, longitude: 2.3668)

    var body: some View {
        SwiftUI.TabView {
            SearchView(viewModel: SearchViewModel(session: Session()))
                .tabItem {
                    Label("Recherche", systemImage: "magnifyingglass")
                }

            Color.gray
                .tabItem {
                    Label("Paramètres", systemImage: "gear")
                }
        }
    }

}

