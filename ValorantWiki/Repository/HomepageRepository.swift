//
//  HomepageRepository.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 10.01.2025.
//

import Foundation

protocol HomepageRepositoryProtocol {
    func fetchAgents(completion: @escaping (NetworkResult<AgentResponse>) -> Void)
}

final class HomepageRepository: HomepageRepositoryProtocol {
    func fetchAgents(completion: @escaping (NetworkResult<AgentResponse>) -> Void) {
        NetworkManager.shared.makeRequest(
            endpoint: HomepageEndpoints.getAgents,
            responseType: AgentResponse.self,
            completion: completion
        )
    }
}
