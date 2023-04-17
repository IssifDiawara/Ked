//
//  RemarkableTree.swift
//  Ked
//
//  Created by Issif DIAWARA on 07/03/2023.
//

import Foundation
import CoreLocation

struct RemarkableTree: Decodable {

    let fields: Fields

}

extension RemarkableTree {

    struct Fields: Decodable {

        let id: Double
        let type: String
        let specie: String
        let name: String
        let address: String
        let additionalAddress: String?
        let district: String
        let coordinate: CLLocationCoordinate2D
        let domaniality: Domaniality
        let implementationDate: Date
        let height: Double

        enum Domaniality: String, Decodable {
            case alignment = "Alignement"
            case cemetery = "CIMETIERE"
            case dac = "DAC"
            case djs = "DJS"
            case garden = "Jardin"
        }

        enum CodingKeys: String, CodingKey {
            case id = "objectid"
            case type = "genre"
            case specie = "espece"
            case name = "libellefrancais"
            case address = "adresse"
            case additionalAddress = "complementadresse"
            case district = "arrondissement"
            case coordinate = "geo_point"
            case domniality = "domanialite"
            case implementationDate = "dateplantation"
            case heigth = "hauteur_en_m"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            id = try container.decode(Double.self, forKey: .id)
            type = try container.decode(String.self, forKey: .type).lowercased()
            specie = try container.decode(String.self, forKey: .specie).lowercased()
            name = try container.decode(String.self, forKey: .name)
            address = try container.decode(String.self, forKey: .address).capitalized
            additionalAddress = try container.decodeIfPresent(String.self, forKey: .additionalAddress)?.capitalized
            district = try container.decode(String.self, forKey: .district)
            domaniality = try container.decode(Domaniality.self, forKey: .domniality)
            height = try container.decode(Double.self, forKey: .heigth)

            let geoPoint = try container.decode([Double].self, forKey: .coordinate)
            coordinate = CLLocationCoordinate2D(latitude: geoPoint[0], longitude: geoPoint[1])

            let date = try container.decode(String.self, forKey: .implementationDate)
            implementationDate = ISO8601DateFormatter().date(from: date) ?? Date()
        }

        // PREVIEW
        init(id: Double,
             type: String,
             specie: String,
             name: String,
             address: String,
             additionalAddress: String? = nil,
             district: String,
             coordinate: CLLocationCoordinate2D,
             domaniality: RemarkableTree.Fields.Domaniality,
             implementationDate: Date,
             height: Double) {
            self.id = id
            self.type = type
            self.specie = specie
            self.name = name
            self.address = address.capitalized
            self.additionalAddress = additionalAddress?.capitalized
            self.district = district
            self.coordinate = coordinate
            self.domaniality = domaniality
            self.implementationDate = implementationDate
            self.height = height
        }
    }

}

struct Coordinate {

    let latitude: Double
    let longitude: Double

}
