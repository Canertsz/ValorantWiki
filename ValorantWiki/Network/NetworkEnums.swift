//
//  NetworkEnums.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 12.02.2025.
//

import Foundation

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case networkError(String)
    case serverError(String)
    
    var errorCode: Int {
        switch self {
        case .networkError:
            return 100
        case .invalidURL:
            return 200
        case .decodingError:
            return 300
        case .serverError:
            return 400
        }
    }
    
    var title: String {
        return "Error (\(errorCode))"
    }

    var description: String {
        return "An error occured"
    }
}

enum NetworkResult<T> {
    case success(T)
    case failure(NetworkError)
}
