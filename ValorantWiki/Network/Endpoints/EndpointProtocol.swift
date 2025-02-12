//
//  EndpointProtocol.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 12.02.2025.
//

import Foundation

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [String: String?]? { get }
}

extension EndpointProtocol {
    var headers: [String: String]? { return nil }
    var queryItems: [URLQueryItem]? { return nil }
}
