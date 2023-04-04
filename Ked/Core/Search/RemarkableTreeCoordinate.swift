//
//  RemarkableTreeCoordinate.swift
//  Ked
//
//  Created by Issif DIAWARA on 03/04/2023.
//

import Foundation
import CoreLocation

struct RemarkableTreeCoordinate: Identifiable {

    let id: UUID
    let coordinate: CLLocationCoordinate2D

    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }

}
