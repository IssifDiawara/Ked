//
//  RemarkableTree.swift
//  Ked
//
//  Created by Issif DIAWARA on 07/03/2023.
//

import Foundation

struct RemarkableTree: Decodable {

    let fields: Fields

}

extension RemarkableTree {

    struct Fields: Decodable {

        let type: String
        let specie: String
        let name: String
        let address: String
        let additionalAddress: String?
        let district: String
        let coordinates: [Double]
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
            case type = "genre"
            case specie = "espece"
            case name = "libellefrancais"
            case address = "adresse"
            case additionalAddress = "complementadresse"
            case district = "arrondissement"
            case coordinates = "geo_point"
            case domniality = "domanialite"
            case implementationDate = "dateplantation"
            case heigth = "hauteur_en_m"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            type = try container.decode(String.self, forKey: .type).lowercased()
            specie = try container.decode(String.self, forKey: .specie).lowercased()
            name = try container.decode(String.self, forKey: .name)
            address = try container.decode(String.self, forKey: .address).capitalized
            additionalAddress = try container.decodeIfPresent(String.self, forKey: .additionalAddress)?.capitalized
            district = try container.decode(String.self, forKey: .district)
            coordinates = try container.decode([Double].self, forKey: .coordinates)
            domaniality = try container.decode(Domaniality.self, forKey: .domniality)
            let date = try container.decode(String.self, forKey: .implementationDate)
            implementationDate = ISO8601DateFormatter().date(from: date) ?? Date()
            height = try container.decode(Double.self, forKey: .heigth)
        }

        // PREVIEW
        init(type: String,
             specie: String,
             name: String,
             address: String,
             additionalAddress: String? = nil,
             district: String,
             coordinates: [Double],
             domaniality: RemarkableTree.Fields.Domaniality,
             implementationDate: Date,
             height: Double) {
            self.type = type
            self.specie = specie
            self.name = name
            self.address = address.capitalized
            self.additionalAddress = additionalAddress?.capitalized
            self.district = district
            self.coordinates = coordinates
            self.domaniality = domaniality
            self.implementationDate = implementationDate
            self.height = height
        }
    }

}

extension RemarkableTree: Identifiable {

    var id: UUID {
        UUID()
    }

}
