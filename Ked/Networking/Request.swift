//
//  Request.swift
//  Ked
//
//  Created by Issif DIAWARA on 07/03/2023.
//

import Foundation

enum Request {

    enum Error: Swift.Error {
        case invalidURL
    }

    var baseURL: URL {
        URL(string: "https://documentation-resources.opendatasoft.com/api/records/1.0/")!
    }

    case remarkableTree(limit: Int)

    func buildURLRequest() throws -> URLRequest {
        var components = URLComponents(url: baseURL.appending(component: path), resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems

        var request = URLRequest(url: (components?.url)!)
        request.httpMethod = "get"

        return request
    }

}

// MARK: - Request path

extension Request {

    var path: String {
        "download"
    }

}

// MARK: - QueryItem

extension Request {

    var queryItems: [URLQueryItem] {
        switch self {
        case let .remarkableTree(limit: limit):
            return [
                URLQueryItem(name: "dataset", value: "les-arbres-remarquables-de-paris"),
                URLQueryItem(name: "rows", value: "\(limit)"),
                URLQueryItem(name: "format", value: "json")
            ]
        }
    }

}
