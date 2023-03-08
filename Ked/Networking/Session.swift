//
//  Session.swift
//  Ked
//
//  Created by Issif DIAWARA on 07/03/2023.
//

import Foundation

struct Session {

    enum Error: Swift.Error {
        case invalidServerResponse
    }

    func loadItems<T: Decodable>(for request: Request) async throws -> T {
        let urlRequest = try request.buildURLRequest()
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw Error.invalidServerResponse}
        return try JSONDecoder().decode(T.self, from: data)
    }

}

