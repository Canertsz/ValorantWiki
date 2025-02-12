//
//  HomepageEndpoints.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 20.12.2024.
//

import Foundation

enum HomepageEndpoints: BaseEndpoint {
    case getAgents
    
    var path: String {
        switch self {
        case .getAgents:
            return "agents"
        }
    }
    
    var url: String {
        return baseURL + path
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAgents:
            return .GET
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getAgents:
            return nil
        }
    }
    
    var queryItems: [String : String?]? {
        switch self {
        case .getAgents:
            return nil
        }
    }
    
}
