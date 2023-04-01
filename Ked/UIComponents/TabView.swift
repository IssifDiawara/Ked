//
//  TabView.swift
//  Ked
//
//  Created by Issif DIAWARA on 01/04/2023.
//

import SwiftUI

struct TabView: View {

    var body: some View {
        SwiftUI.TabView {
            Color.indigo
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

