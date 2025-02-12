//
//  NetworkManager.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 20.12.2024.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    func makeRequest<T: Decodable>(endpoint: EndpointProtocol, responseType: T.Type, completion: (@escaping (NetworkResult<T>) -> Void)) {
        guard let url = URL(string: endpoint.url) else {
            print("invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        if let headers = endpoint.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print("Network error occurred: \(error.localizedDescription)")
                
                completion(.failure(.networkError(error.localizedDescription)))
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                guard (200...299).contains(httpResponse.statusCode) else {
                    print("Server responded with status code: \(httpResponse.statusCode)")
                    
                    completion(.failure(.serverError("Server returned status code \(httpResponse.statusCode)")))
                    return
                }
            } else {
                print("Unexpected response format")
                
                completion(.failure(.serverError("Invalid response from server")))
                return
            }

            do {
                guard let data else { return }

                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(.decodingError))
            }

        }.resume()
    }
}
