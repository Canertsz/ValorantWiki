//
//  BaseEndpoint.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 12.02.2025.
//

protocol BaseEndpoint: EndpointProtocol {
    var baseURL: String { get }
}

extension BaseEndpoint {
    var baseURL: String {
        "https://valorant-api.com/v1/"
    }
}
